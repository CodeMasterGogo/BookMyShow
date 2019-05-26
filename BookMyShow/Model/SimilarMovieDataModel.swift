//
//  SimilarMovieDataModel.swift
//  BookMyShow
//
//  Created by Girish Rao on 27/05/19.
//  Copyright © 2019 Finward. All rights reserved.
//

import Foundation

struct SimilarMovieData{
    var results: [SimilarMovies]?
}

extension SimilarMovieData: Decodable{
    private enum ResponseCodingKeys: String, CodingKey {
        case results
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ResponseCodingKeys.self)
        
        if let results = try container.decodeIfPresent([SimilarMovies].self, forKey: .results){
            self.results = results
        }
    }
}

struct SimilarMovies{
    var title: String = ""
    var posterUrl: String = ""
    var releaseDate: String = ""
}

extension SimilarMovies: Decodable{
    private enum ResponseCodingKeys: String, CodingKey {
        case releaseDate = "release_date"
        case posterUrl = "poster_path"
        case title
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ResponseCodingKeys.self)
        
        if let title = try container.decodeIfPresent(String.self, forKey: .title){
            self.title = title
        }
        if let posterUrl = try container.decodeIfPresent(String.self, forKey: .posterUrl){
            self.posterUrl = posterUrl
        }
        if let releaseDate = try container.decodeIfPresent(String.self, forKey: .releaseDate){
            self.releaseDate = releaseDate
        }
    }
}
