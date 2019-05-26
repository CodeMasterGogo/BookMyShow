//
//  MovieNetworkManger.swift
//  BookMyShow
//
//  Created by Girish Rao on 25/05/19.
//  Copyright © 2019 Finward. All rights reserved.
//

import Foundation

enum apiSuccessType: Int{
    case showDataView = 0, noDataView, errorView
}

struct MovieNetworkManger {
    
    let router = Router<MovieEndpoint>()
    
    func getMovieData(data: [String: Any], completion: @escaping (_ success: apiSuccessType, _ response: MovieData?) ->()){
        router.request(.getMovieData(data: data)) { data, msg, isSuccess  in
            
            if isSuccess{
                guard let responseData = data else {
                    DispatchQueue.main.async {
                        completion(.noDataView, nil)
                    }
                    return
                }
                do {
                    let apiResponse = try JSONDecoder().decode(MovieData.self, from: responseData)
                    completion(.showDataView, apiResponse)
                }catch {
                    print(error)
                    DispatchQueue.main.async {
                        completion(.noDataView, nil)
                    }
                }
            }
            else{
                completion(.noDataView, nil)
            }
        }
    }
    
    func getMovieDetail(id: Int, data: [String: Any], completion: @escaping (_ success: apiSuccessType, _ response: MovieDetailData?) ->()){
        router.request(.getMovieDetailData(movieID: id, data: data)) { data, msg, isSuccess  in
            
            if isSuccess{
                guard let responseData = data else {
                    DispatchQueue.main.async {
                        completion(.noDataView, nil)
                    }
                    return
                }
                do {
                    let apiResponse = try JSONDecoder().decode(MovieDetailData.self, from: responseData)
                    completion(.showDataView, apiResponse)
                }catch {
                    print(error)
                    DispatchQueue.main.async {
                        completion(.noDataView, nil)
                    }
                }
            }
            else{
                completion(.noDataView, nil)
            }
        }
    }
    
    func getCastNcrew(id: Int, data: [String: Any], completion: @escaping (_ success: apiSuccessType, _ response: CastnCrewData?) ->()){
        router.request(.getCastnCrewData(movieID: id, data: data)) { data, msg, isSuccess  in
            
            if isSuccess{
                guard let responseData = data else {
                    DispatchQueue.main.async {
                        completion(.noDataView, nil)
                    }
                    return
                }
                do {
                    let apiResponse = try JSONDecoder().decode(CastnCrewData.self, from: responseData)
                    completion(.showDataView, apiResponse)
                }catch {
                    print(error)
                    DispatchQueue.main.async {
                        completion(.noDataView, nil)
                    }
                }
            }
            else{
                completion(.noDataView, nil)
            }
        }
    }
    
    func getReviewData(id: Int, data: [String: Any], completion: @escaping (_ success: apiSuccessType, _ response: ReviewData?) ->()){
        router.request(.getReviewData(movieID: id, data: data)) { data, msg, isSuccess  in
            
            if isSuccess{
                guard let responseData = data else {
                    DispatchQueue.main.async {
                        completion(.noDataView, nil)
                    }
                    return
                }
                do {
                    let apiResponse = try JSONDecoder().decode(ReviewData.self, from: responseData)
                    completion(.showDataView, apiResponse)
                }catch {
                    print(error)
                    DispatchQueue.main.async {
                        completion(.noDataView, nil)
                    }
                }
            }
            else{
                completion(.noDataView, nil)
            }
        }
    }
    
    func getSimilarData(id: Int, data: [String: Any], completion: @escaping (_ success: apiSuccessType, _ response: SimilarMovieData?) ->()){
        router.request(.getSimilarData(movieID: id, data: data)) { data, msg, isSuccess  in
            
            if isSuccess{
                guard let responseData = data else {
                    DispatchQueue.main.async {
                        completion(.noDataView, nil)
                    }
                    return
                }
                do {
                    let apiResponse = try JSONDecoder().decode(SimilarMovieData.self, from: responseData)
                    completion(.showDataView, apiResponse)
                }catch {
                    print(error)
                    DispatchQueue.main.async {
                        completion(.noDataView, nil)
                    }
                }
            }
            else{
                completion(.noDataView, nil)
            }
        }
    }
}
