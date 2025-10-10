//
//  RMGetAllCharacterResponse.swift
//  RickAndMorty
//
//  Created by Sai Teja Atluri on 9/2/25.
//

import Foundation

struct RMGetAllCharacterResponse: Codable {
    struct Info: Codable {
        let count: Int
        let pages: Int
        let next: String?
        let prev: String?
    }
     
    let info: Info
    let results: [RMCharacter]
}
