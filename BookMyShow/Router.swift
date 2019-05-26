//
//  NetworkService.swift
//  NetworkLayer
//
//  Created by Malcolm Kumwenda on 2018/03/07.
//  Copyright © 2018 Malcolm Kumwenda. All rights reserved.
//

import Foundation

public typealias NetworkRouterCompletion = (_ data: Data?, _ msg: String?, _ isSuccess: Bool)->()

protocol NetworkRouter: class {
    associatedtype EndPoint: EndPointType
    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion)
    func cancel()
}

enum Result<String>{
    case success
    case failure(String)
    case authenticationfailure(String)
}

enum NetworkResponse:String {
    case success
    case authenticationError = "You need to be authenticated first."
    case badRequest = "Bad request"
    case outdated = "The url you requested is outdated."
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "We could not decode the response."
}

class Router<EndPoint: EndPointType>: NetworkRouter {
    private var task: URLSessionTask?
    
    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion) {
        let session = URLSession.shared
        do {
            let request = try self.buildRequest(from: route)
            NetworkLogger.log(request: request)
            task = session.dataTask(with: request, completionHandler: { data, response, error in
                
                if error != nil {
                    completion(nil, "Please check your network connection.", false)
                }
                
                if let response = response as? HTTPURLResponse {
                    session.configuration.urlCache?.removeAllCachedResponses()
                    let result = self.handleNetworkResponse(response)
                    switch result {
                    case .success:
                        completion(data, "", true)
                        break
                    case .failure(let networkFailureError):
                            if data != nil{
                                completion(data, networkFailureError, true)
                            }
                            else{
                                DispatchQueue.main.async {
                                    completion(data, networkFailureError, false)
                                }
                            }
                        break
                    case .authenticationfailure(let authenticationError):
                        DispatchQueue.main.async {
                            completion(nil, authenticationError, false)
                        }
                        break
                    }
                }
                else
                {
                    DispatchQueue.main.async {
                        completion(nil, "Please check your network connection.", false)
                    }
                }
            })
        }catch {
            DispatchQueue.main.async {
                completion(nil, NetworkResponse.noData.rawValue, false)
            }
        }
        self.task?.resume()
    }
    
    func cancel() {
        self.task?.cancel()
    }
    
    fileprivate func buildRequest(from route: EndPoint) throws -> URLRequest {
        
        var request = URLRequest(url: route.baseURL.appendingPathComponent(route.path),
                                 cachePolicy: .useProtocolCachePolicy,
                                 timeoutInterval: 10.0)
        request.setValue("no-cache", forHTTPHeaderField: "Cache-Control")
        request.httpMethod = route.httpMethod.rawValue
        do {
            switch route.task {
             case .request:
                   request.setValue("application/json", forHTTPHeaderField: "Content-Type")
             case .requestParameters(let bodyParameters,
                                    let bodyEncoding,
                                    let urlParameters):
                
                try self.configureParameters(bodyParameters: bodyParameters,
                                             bodyEncoding: bodyEncoding,
                                             urlParameters: urlParameters,
                                             request: &request)
                
            case .requestParametersAndHeaders(let bodyParameters,
                                              let bodyEncoding,
                                              let urlParameters,
                                              let additionalHeaders):
                
                self.addAdditionalHeaders(additionalHeaders, request: &request)
                try self.configureParameters(bodyParameters: bodyParameters,
                                             bodyEncoding: bodyEncoding,
                                             urlParameters: urlParameters,
                                             request: &request)
            case .multipartRequest(let bodyParameters):
                let boundary = "Boundary-\(UUID().uuidString)"
                request.cachePolicy = URLRequest.CachePolicy.reloadIgnoringCacheData
                request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
                request.httpBody = createDataBody(withParameters: bodyParameters as! [String : String], boundary: boundary)
                
            case .multipartUploadingImageRequest(let imageData, let fileName):
                let boundary = "Boundary-\(UUID().uuidString)"
                request.cachePolicy = URLRequest.CachePolicy.reloadIgnoringCacheData
                request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
                request.httpBody = createDataBodyForFileUploading(boundary: boundary, imageData: imageData, fileName: fileName)
            }
            return request
        } catch {
            throw error
        }
    }
    
    fileprivate func configureParameters(bodyParameters: Parameters?,
                                         bodyEncoding: ParameterEncoding,
                                         urlParameters: Parameters?,
                                         request: inout URLRequest) throws {
        do {
            try bodyEncoding.encode(urlRequest: &request,
                                    bodyParameters: bodyParameters, urlParameters: urlParameters)
        } catch {
            throw error
        }
    }
    
    fileprivate func addAdditionalHeaders(_ additionalHeaders: HTTPHeaders?, request: inout URLRequest) {
        guard let headers = additionalHeaders else { return }
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }

    fileprivate func createDataBody(withParameters params: [String: String], boundary: String) -> Data {
        
        let lineBreak = "\r\n"
        var body = Data()
        
            for (key, value) in params {
                body.append("--\(boundary + lineBreak)")
                body.append("Content-Disposition: form-data; name=\"\(key)\"\(lineBreak + lineBreak)")
                body.append("\(value + lineBreak)")
            }
        body.append("--\(boundary)--\(lineBreak)")
        return body
    }
    
    fileprivate func createDataBodyForFileUploading(boundary: String, imageData: Data, fileName: String) -> Data {
        let lineBreak = "\r\n"
        var body = Data()
        let mimetype = "image/jpg"
        body.append("--\(boundary)\r\n")
        body.append("Content-Disposition: form-data; name=\"res\"; filename=\"\(fileName)\"\r\n")
        body.append("Content-Type: \(mimetype)\r\n\r\n")
        body.append(imageData)
        body.append("\r\n")
        body.append("--\(boundary)--\(lineBreak)")
        return body
    }
    
    fileprivate func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String>{
        switch response.statusCode {
        case 200...399: return .success
        case 401: return .authenticationfailure(NetworkResponse.authenticationError.rawValue)
        case 402...499: return .failure(NetworkResponse.authenticationError.rawValue)
        case 500...599: return .failure(NetworkResponse.badRequest.rawValue)
        case 600: return .failure(NetworkResponse.outdated.rawValue)
        default: return .failure(NetworkResponse.failed.rawValue)
        }
    }
    
    func generateBoundary() -> String {
        return "Boundary-\(NSUUID().uuidString)"
    }
}

extension Data {
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}
