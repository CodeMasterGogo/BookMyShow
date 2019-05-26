//
//  MovieDataModel.swift
//  BookMyShow
//
//  Created by Girish Rao on 25/05/19.
//  Copyright © 2019 Finward. All rights reserved.
//

import Foundation


struct MovieData{
    var movies: [MovieObject]?
    var currentPage: Int = 0
    var totalResults: Int = 0
    var totalPages: Int = 0
    var dates: DateObj?
}

extension MovieData: Decodable{
    private enum ResponseCodingKeys: String, CodingKey {
        case movies = "results"
        case currentPage = "page"
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case dates
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ResponseCodingKeys.self)
        
        if let movies = try container.decodeIfPresent([MovieObject].self, forKey: .movies){
            self.movies = movies
        }
        if let currentPage = try container.decodeIfPresent(Int.self, forKey: .currentPage){
            self.currentPage = currentPage
        }
        if let totalResults = try container.decodeIfPresent(Int.self, forKey: .totalResults){
            self.totalResults = totalResults
        }
        if let totalPages = try container.decodeIfPresent(Int.self, forKey: .totalPages){
            self.totalPages = totalPages
        }
        if let dates = try container.decodeIfPresent(DateObj.self, forKey: .dates){
            self.dates = dates
        }
    }
}

struct MovieObject{
    var voteCount: Int = 0
    var id: Int = 0
    var isVedio: Bool = false
    var voteAverage: Double = 0.0
    var title: String = ""
    var popularity: Double = 0.0
    var posterPath: String = ""
    var originalLanguage: String = ""
    var originalTitle: String = ""
    var relaeseDate: String = ""
    var overview: String = ""
    var isAdult: Bool = false
    var backdropPath: String = ""
    var genreIds: [Int]?
}

extension MovieObject: Decodable{
    private enum ResponseCodingKeys: String, CodingKey {
        case voteCount = "vote_count"
        case id
        case isVedio = "video"
        case voteAverage = "vote_average"
        case title
        case popularity
        case posterPath = "poster_path"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case relaeseDate = "release_date"
        case overview
        case isAdult = "adult"
        case backdropPath = "backdrop_path"
        case genreIds = "genre_ids"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ResponseCodingKeys.self)
        
        if let voteCount = try container.decodeIfPresent(Int.self, forKey: .voteCount){
            self.voteCount = voteCount
        }
        if let id = try container.decodeIfPresent(Int.self, forKey: .id){
            self.id = id
        }
        if let isVedio = try container.decodeIfPresent(Bool.self, forKey: .isVedio){
            self.isVedio = isVedio
        }
        if let voteAverage = try container.decodeIfPresent(Double.self, forKey: .voteAverage){
            self.voteAverage = voteAverage
        }
        if let title = try container.decodeIfPresent(String.self, forKey: .title){
            self.title = title
        }
        if let popularity = try container.decodeIfPresent(Double.self, forKey: .popularity){
            self.popularity = popularity
        }
        if let posterPath = try container.decodeIfPresent(String.self, forKey: .posterPath){
            self.posterPath = posterPath
        }
        if let originalLanguage = try container.decodeIfPresent(String.self, forKey: .originalLanguage){
            self.originalLanguage = originalLanguage
        }
        if let originalTitle = try container.decodeIfPresent(String.self, forKey: .originalTitle){
            self.originalTitle = originalTitle
        }
        if let relaeseDate = try container.decodeIfPresent(String.self, forKey: .relaeseDate){
            self.relaeseDate = relaeseDate
        }
        if let overview = try container.decodeIfPresent(String.self, forKey: .overview){
            self.overview = overview
        }
        if let backdropPath = try container.decodeIfPresent(String.self, forKey: .backdropPath){
            self.backdropPath = backdropPath
        }
        if let isAdult = try container.decodeIfPresent(Bool.self, forKey: .isAdult){
            self.isAdult = isAdult
        }
        if let genreIds = try container.decodeIfPresent([Int].self, forKey: .genreIds){
            self.genreIds = genreIds
        }
    }
}

struct DateObj{
    var maxDate: String = ""
    var minDate: String = ""
}

extension DateObj: Decodable{
    private enum ResponseCodingKeys: String, CodingKey {
        case maxDate = "maximum"
        case minDate = "minimum"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ResponseCodingKeys.self)
        
        if let maxDate = try container.decodeIfPresent(String.self, forKey: .maxDate){
            self.maxDate = maxDate
        }
        if let minDate = try container.decodeIfPresent(String.self, forKey: .minDate){
            self.minDate = minDate
        }
    }
}
