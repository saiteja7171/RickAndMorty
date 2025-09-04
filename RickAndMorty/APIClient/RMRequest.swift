//
//  RMRequest.swift
//  RickAndMorty
//
//  Created by Sai Teja Atluri on 8/27/25.
//

import Foundation

final class RMRequest {
    
    private struct Constants {
        static let baseURLString = "https://rickandmortyapi.com/api/"
    }
    
    private let endpoint: RMEndpoint
    private let pathComponents: [String]
    private let queryParameters: [URLQueryItem]
    
    private var urlString: String {
        var string = Constants.baseURLString
        string += endpoint.rawValue
        if !pathComponents.isEmpty {
            pathComponents.forEach { string += "/\($0)" }
        }
        if !queryParameters.isEmpty {
            string += "?"
            let argumentString = queryParameters.compactMap({
                guard let value = $0.value else { return nil }
                return "\($0.name)=\(value)"
            }).joined(separator: "&")
            string += argumentString
        }
        return string
    }
    
    public var url: URL? {
        return URL(string: urlString)
    }
    
    public init(endpoint: RMEndpoint, pathComponents: [String] = [], queryParameters: [URLQueryItem] = []) {
        self.endpoint = endpoint
        self.pathComponents = pathComponents
        self.queryParameters = queryParameters
    }
    
    
}

extension RMRequest {
    static let listCharatersRequest = RMRequest(endpoint: .character)
    static let listLocationRequest = RMRequest(endpoint: .location)
    static let listEpisodeRequest = RMRequest(endpoint: .episode)
}
