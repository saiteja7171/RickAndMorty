//
//  RMRequest.swift
//  RickAndMorty
//
//  Created by Sai Teja Atluri on 8/27/25.
//

import Foundation

final class RMRequest {
    
    private struct Constants {
        static let baseURLString = "https://rickandmortyapi.com/api"
    }
    
    private let endpoint: RMEndpoint
    private let pathComponents: [String]
    private let queryParameters: [URLQueryItem]
    
    private var urlString: String {
        var string = Constants.baseURLString
        string += "/"
        string += endpoint.rawValue

        if !pathComponents.isEmpty {
            pathComponents.forEach({
                string += "/\($0)"
            })
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
    
    convenience init?(url: URL) {
        let string = url.absoluteString
        if !string.contains(Constants.baseURLString) {
            return nil
        }
        let trimmed = string.replacingOccurrences(of: Constants.baseURLString + "/", with: "")
        if trimmed.contains("/") {
            let components = trimmed.components(separatedBy: "/")
            if !components.isEmpty {
                let endpoint = components[0]
                if let rmEndpoint = RMEndpoint(rawValue: endpoint) {
                    self.init(endpoint: rmEndpoint)
                    return
                }
            }
        } else if trimmed.contains("?") {
            let components = trimmed.components(separatedBy: "?")
            if !components.isEmpty,components.count >= 2 {
                let endpoint = components[0]
                let queryItemString = components[1]
                let queryItem: [URLQueryItem] = queryItemString.components(separatedBy: "&").compactMap({
                    guard $0.contains("=") else { return nil }
                    let part = $0.components(separatedBy: "=")
                    return URLQueryItem(name: part[0], value: part[1])
                })
                if let rmEndpoint = RMEndpoint(rawValue: endpoint) {
                    self.init(endpoint: rmEndpoint, queryParameters: queryItem)
                    return
                }
            }
        }
        return nil
    }
    
}

extension RMRequest {
    static let listCharatersRequest = RMRequest(endpoint: .character)
    static let listLocationRequest = RMRequest(endpoint: .location)
    static let listEpisodeRequest = RMRequest(endpoint: .episode)
}
