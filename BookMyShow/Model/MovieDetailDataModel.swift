//
//  MovieDetailDataModel.swift
//  BookMyShow
//
//  Created by Girish Rao on 26/05/19.
//  Copyright © 2019 Finward. All rights reserved.
//

import Foundation



struct MovieDetailData{
    var title: String = ""
    var overview: String = ""
    var releaseDate: String = ""
    var voteCount: Int = 0
    var posterUrl: String = ""
    var popularity: String = ""
    var isAdult: Bool = false
    var movieType: String = ""
    var status: String = ""
    var languages: [MovieLanguage]?
    var genres: [Genres]?
    var runtime: Double = 0.0
}

extension MovieDetailData: Decodable{
    private enum ResponseCodingKeys: String, CodingKey {
        case title
        case overview = "overview"
        case releaseDate = "release_date"
        case voteCount = "vote_count"
        case posterUrl = "poster_path"
        case popularity = "popularity"
        case isAdult = "adult"
        case movieType
        case status
        case languages =  "spoken_languages"
        case genres = "genres"
        case runtime
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ResponseCodingKeys.self)
        
        if let title = try container.decodeIfPresent(String.self, forKey: .title){
            self.title = title
        }
        if let overview = try container.decodeIfPresent(String.self, forKey: .overview){
            self.overview = overview
        }
        if let releaseDate = try container.decodeIfPresent(String.self, forKey: .releaseDate){
            self.releaseDate = releaseDate
        }
        if let voteCount = try container.decodeIfPresent(Int.self, forKey: .voteCount){
            self.voteCount = voteCount
        }
        if let posterUrl = try container.decodeIfPresent(String.self, forKey: .posterUrl){
            self.posterUrl = posterUrl
        }
        if let isAdult = try container.decodeIfPresent(Bool.self, forKey: .isAdult){
            self.isAdult = isAdult
            self.movieType = isAdult ? "A": "U"
        }
        if let languages = try container.decodeIfPresent([MovieLanguage].self, forKey: .languages){
            self.languages = languages
        }
        if let genres = try container.decodeIfPresent([Genres].self, forKey: .genres){
            self.genres = genres
        }
        if let status = try container.decodeIfPresent(String.self, forKey: .status){
            self.status = status
        }
        if let runtime = try container.decodeIfPresent(Double.self, forKey: .runtime){
            self.runtime = runtime
        }
    }
}

struct MovieLanguage{
    var id: String = ""
    var language: String = ""
}

extension MovieLanguage: Decodable{
    private enum ResponseCodingKeys: String, CodingKey {
        case id = "iso_639_1"
        case language = "name"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ResponseCodingKeys.self)
        
        if let id = try container.decodeIfPresent(String.self, forKey: .id){
            self.id = id
        }
        if let language = try container.decodeIfPresent(String.self, forKey: .language){
            self.language = language
        }
    }
}

struct Genres{
    var id: Int = 0
    var name: String = ""
}

extension Genres: Decodable{
    private enum ResponseCodingKeys: String, CodingKey {
        case id
        case name
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ResponseCodingKeys.self)
        
        if let id = try container.decodeIfPresent(Int.self, forKey: .id){
            self.id = id
        }
        if let name = try container.decodeIfPresent(String.self, forKey: .name){
            self.name = name
        }
    }
}
