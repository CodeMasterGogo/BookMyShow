//
//  MoviePresenter.swift
//  BookMyShow
//
//  Created by Girish Rao on 25/05/19.
//  Copyright © 2019 Finward. All rights reserved.
//

import Foundation

protocol MovieDelegate{
    func showProgress()
    func hideProgress()
    func getMovieData(movieArr: [MovieObject], totalPage: Int, currentPage: Int)
    func failedtogetMovieData(message: String)
}

class MoviePresenter {
    var delegate: MovieDelegate?
    let networkManger = MovieNetworkManger()
    
    init(delegate: MovieDelegate) {
        self.delegate = delegate
    }
    
    func getMoviewData(apikey: String, page: Int){
        self.delegate?.showProgress()
        let data: [String: Any] = ["api_key": apikey, "page": page]
        networkManger.getMovieData(data: data) { [weak self] (success, response) in
            self?.delegate?.hideProgress()
            switch success{
            case .showDataView :
                if let obj = response?.movies{
                    self?.delegate?.getMovieData(movieArr: obj, totalPage: response?.totalPages ?? 0, currentPage: response?.currentPage ?? 1)
                }
                break
            default:
                self?.delegate?.failedtogetMovieData(message: "No Data Found")
                break
                
            }
        }
    }
}
