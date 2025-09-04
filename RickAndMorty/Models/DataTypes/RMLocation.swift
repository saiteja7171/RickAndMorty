//
//  RMLocation.swift
//  RickAndMorty
//
//  Created by Sai Teja Atluri on 8/25/25.
//

import Foundation

struct RMLocation: Codable {
    let id: Int
    let name: String
    let type: String
    let dimension: String
    let url: String
    let residents: [String]
    let created: String
}


 
