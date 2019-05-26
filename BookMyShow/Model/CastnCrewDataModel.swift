//
//  CastnCrewDataModel.swift
//  BookMyShow
//
//  Created by Girish Rao on 26/05/19.
//  Copyright © 2019 Finward. All rights reserved.
//

import Foundation

struct CastnCrewData{
    var id: Int = 0
    var cast: [CastObj]?
    var crew: [CrewObj]?
}

extension CastnCrewData: Decodable{
    private enum ResponseCodingKeys: String, CodingKey {
        case cast
        case crew
        case id
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ResponseCodingKeys.self)
        
        if let id = try container.decodeIfPresent(Int.self, forKey: .id){
            self.id = id
        }
        if let cast = try container.decodeIfPresent([CastObj].self, forKey: .cast){
            self.cast = cast
        }
        if let crew = try container.decodeIfPresent([CrewObj].self, forKey: .crew){
            self.crew = crew
        }
    }
}


struct CastObj{
    var character: String = ""
    var name: String = ""
    var profileUrl: String = ""
}

extension CastObj: Decodable{
    private enum ResponseCodingKeys: String, CodingKey {
        case character
        case name
        case profileUrl = "profile_path"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ResponseCodingKeys.self)
        
        if let character = try container.decodeIfPresent(String.self, forKey: .character){
            self.character = character
        }
        if let name = try container.decodeIfPresent(String.self, forKey: .name){
            self.name = name
        }
        if let profileUrl = try container.decodeIfPresent(String.self, forKey: .profileUrl){
            self.profileUrl = profileUrl
        }
    }
}

struct CrewObj{
    var job: String = ""
    var name: String = ""
    var profileUrl: String = ""
}

extension CrewObj: Decodable{
    private enum ResponseCodingKeys: String, CodingKey {
        case job
        case name
        case profileUrl = "profile_path"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ResponseCodingKeys.self)
        
        if let job = try container.decodeIfPresent(String.self, forKey: .job){
            self.job = job
        }
        if let name = try container.decodeIfPresent(String.self, forKey: .name){
            self.name = name
        }
        if let profileUrl = try container.decodeIfPresent(String.self, forKey: .profileUrl){
            self.profileUrl = profileUrl
        }
    }
}
