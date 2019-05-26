//
//  MovieEndpoint.swift
//  BookMyShow
//
//  Created by Girish Rao on 25/05/19.
//  Copyright © 2019 Finward. All rights reserved.
//

import Foundation

public enum MovieEndpoint {
    case getMovieData(data: [String: Any])
    case getMovieDetailData(movieID: Int, data: [String: Any])
    case getCastnCrewData(movieID: Int, data: [String: Any])
    case getSimilarData(movieID: Int, data: [String: Any])
    case getReviewData(movieID: Int, data: [String: Any])
}

extension MovieEndpoint: EndPointType {
    
    var environmentBaseURL : String {
        return "https://api.themoviedb.org/3"
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
        case .getMovieData:
            return "/movie/now_playing"
        case .getMovieDetailData(let movieID, _):
            return "/movie/\(movieID)"
        case .getCastnCrewData(let movieID, _):
            return "/movie/\(movieID)/credits"
        case .getSimilarData(let movieID, _):
            return "/movie/\(movieID)/similar"
        case .getReviewData(let movieID, _):
            return "/movie/\(movieID)/reviews"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getMovieData:
            return .get
        case .getCastnCrewData:
            return .get
        case .getSimilarData:
            return .get
        case .getMovieDetailData:
            return .get
        case .getReviewData:
            return .get
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .getMovieData(let data):
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: data)
        case .getCastnCrewData( _, let data):
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: data)
        case .getSimilarData( _, let data):
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: data)
        case .getMovieDetailData( _, let data):
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: data)
        case .getReviewData( _, let data):
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: data)
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}
