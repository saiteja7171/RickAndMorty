//
//  RMService.swift
//  RickAndMorty
//
//  Created by Sai Teja Atluri on 8/27/25.
//

import Foundation

final class RMService {
    static let shared = RMService()
    
    private init() {}
    
    public func execute(_ request: RMRequest, completion: @escaping () -> Void) {
        
    }
}
