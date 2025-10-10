//
//  RMGetAllLocationResponse.swift
//  RickAndMorty
//
//  Created by Sai Teja Atluri on 9/4/25.
//

import Foundation
struct RMGetAllLocationResponse: Codable {
    struct Info: Codable {
        let count: Int
        let pages: Int
        let next: String?
        let prev: String?
    }
    let results: [RMLocation]
}
