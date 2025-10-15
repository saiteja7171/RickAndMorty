//
//  RMEpisode.swift
//  RickAndMorty
//
//  Created by Sai Teja Atluri on 8/25/25.
//

import Foundation

struct RMEpisode: Codable, RMEpisodeDataRender {
    let id: Int
    let name: String
    let air_date: String
    let episode: String
    let characters: [String]
    let url: String
    let created: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case air_date = "air_date"
        case episode
        case characters
        case url
        case created
    }
}



