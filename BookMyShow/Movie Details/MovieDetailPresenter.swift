//
//  MovieDetailPresenter.swift
//  BookMyShow
//
//  Created by Girish Rao on 25/05/19.
//  Copyright © 2019 Finward. All rights reserved.
//

import Foundation
protocol MovieDetailDelegate{
    func showProgress()
    func hideProgress()
    func getMovieData(obj: MovieDetailData?)
    func getCastNCrewData(obj: CastnCrewData?)
    func getSimilarMovieData(obj: SimilarMovieData?)
    func getMovieReviewData(obj: ReviewData?)
    func failedtogetMovieData(message: String)
}

class MovieDetailPresenter {
    var delegate: MovieDetailDelegate?
    let networkManger = MovieNetworkManger()
    let data: [String: Any] = ["api_key": "f6290311bc8744c23f0c450481125a0c"]
    let dispatchGroup = DispatchGroup()
    
    init(delegate: MovieDetailDelegate) {
        self.delegate = delegate
    }
    
    func downloadDetails(movieId: Int){
        delegate?.showProgress()
        dispatchGroup.enter()
        getMovieDetail(movieId: movieId)
        dispatchGroup.enter()
        getCastnCrewDetail(movieId: movieId)
        dispatchGroup.enter()
        similarMovieDetail(movieId: movieId)
        dispatchGroup.enter()
        getReviewData(movieId: movieId)
        
        dispatchGroup.notify(queue: .main) {
            self.delegate?.hideProgress()
        }
    }
    
    func getMovieDetail(movieId: Int){
        networkManger.getMovieDetail(id: movieId, data: data) { [weak self] (success, response) in
            switch success{
            case .showDataView :
                if let obj = response{
                    self?.delegate?.getMovieData(obj: obj)
                }
                break
            default:
                self?.delegate?.failedtogetMovieData(message: "No Data Found")
                break
                
            }
            DispatchQueue.main.async {
                self?.dispatchGroup.leave() 
            }
        }
    }
    
    func getCastnCrewDetail(movieId: Int){
        networkManger.getCastNcrew(id: movieId, data: data) { [weak self] (success, response) in
            switch success{
            case .showDataView :
                if let obj = response{
                    self?.delegate?.getCastNCrewData(obj: obj)
                }
                break
            default:
                self?.delegate?.failedtogetMovieData(message: "No Data Found")
                break
                
            }
            DispatchQueue.main.async {
                self?.dispatchGroup.leave()
            }
        }
    }
    
    func similarMovieDetail(movieId: Int){
        networkManger.getSimilarData(id: movieId, data: data) { [weak self] (success, response) in
            switch success{
            case .showDataView :
                if let obj = response{
                    self?.delegate?.getSimilarMovieData(obj: obj)
                }
                break
            default:
                self?.delegate?.failedtogetMovieData(message: "No Data Found")
                break
                
            }
            DispatchQueue.main.async {
                self?.dispatchGroup.leave()
            }
        }
    }
    
    func getReviewData(movieId: Int){
        networkManger.getReviewData(id: movieId, data: data) { [weak self] (success, response) in
            switch success{
            case .showDataView :
                if let obj = response{
                    self?.delegate?.getMovieReviewData(obj: obj)
                }
                break
            default:
                self?.delegate?.failedtogetMovieData(message: "No Data Found")
                break
                
            }
            DispatchQueue.main.async {
                self?.dispatchGroup.leave()
            }
        }
    }
}

