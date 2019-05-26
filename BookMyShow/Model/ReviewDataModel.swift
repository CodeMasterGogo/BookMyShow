//
//  ReviewDataModel.swift
//  BookMyShow
//
//  Created by Girish Rao on 27/05/19.
//  Copyright © 2019 Finward. All rights reserved.
//

import Foundation

struct ReviewData{
    var results: [ReviewResult]?
}

extension ReviewData: Decodable{
    private enum ResponseCodingKeys: String, CodingKey {
        case results
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ResponseCodingKeys.self)
        
        if let results = try container.decodeIfPresent([ReviewResult].self, forKey: .results){
            self.results = results
        }
    }
}

struct ReviewResult{
    var author: String = ""
    var content: String = "No Review"
}

extension ReviewResult: Decodable{
    private enum ResponseCodingKeys: String, CodingKey {
        case author
        case content
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ResponseCodingKeys.self)
        
        if let content = try container.decodeIfPresent(String.self, forKey: .content){
            self.content = content
        }
        if let author = try container.decodeIfPresent(String.self, forKey: .author){
            self.author = author
        }
    }
}
