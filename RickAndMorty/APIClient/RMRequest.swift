//
//  RMRequest.swift
//  RickAndMorty
//
//  Created by Afraz Siddiqui on 12/23/22.
//

import Foundation
///
/// Object that represents a singlet API call
final class RMRequest {
    /// API Constants
    private struct Constants {
        static let baseUrl = "https://rickandmortyapi.com/api"
    }

    /// Desired endpoint
    let endpoint: RMEndpoint

    /// Path components for API, if any
    private let pathComponents: [String]

    /// Query arguments for API, if any
    private let queryParameters: [URLQueryItem]

    /// Constructed url for the api request in string format
    private var urlString: String {
        var string = Constants.baseUrl
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
            print("String \(string)")
        }

        return string
    }

    /// Computed & constructed API url
    public var url: URL? {
        return URL(string: urlString)
    }

    /// Desired http method
    public let httpMethod = "GET"

    // MARK: - Public

    /// Construct request
    /// - Parameters:
    ///   - endpoint: Target endpoint
    ///   - pathComponents: Collection of Path components
    ///   - queryParameters: Collection of query parameters
    public init(
        endpoint: RMEndpoint,
        pathComponents: [String] = [],
        queryParameters: [URLQueryItem] = []
    ) {
        self.endpoint = endpoint
        self.pathComponents = pathComponents
        self.queryParameters = queryParameters
    }

    /// Attempt to create request
    /// - Parameter url: URL to parse
    convenience init?(url: URL) {
        let string = url.absoluteString
        
        // string: https://rickandmortyapi.com/api/character/1
        
        if !string.contains(Constants.baseUrl) { return nil }
        
        let trimmed = string.replacingOccurrences(of: Constants.baseUrl+"/", with: "")
        
        // 2) Remove "https://rickandmortyapi.com/api/"
        // trimmed: character/1

        if trimmed.contains("/") {
            // trimmed = "character/1"
            
            let components = trimmed.components(separatedBy: "/")
            
            // Treat as endpoint + path
            // components: ["character", "1"]
            
            if !components.isEmpty {
                let endpointString = components[0] // Endpoint
                
                // endpointString: character
                
                var pathComponents: [String] = []
                if components.count > 1 {
                    pathComponents = components
                    
                   // Before removing pathcomponent: ["character", "1"]

                    pathComponents.removeFirst()
                    
                   // After removing pathcomponent: ["1"]

                }
                if let rmEndpoint = RMEndpoint(
                    rawValue: endpointString
                ) {
                    self.init(endpoint: rmEndpoint, pathComponents: pathComponents)
                    return
                }
            }
        } else if trimmed.contains("?")  {
            // Original string before trimming https://rickandmortyapi.com/api/character?page=2
            // trimmed: character?page=2

            let components = trimmed.components(separatedBy: "?")
            // components: ["character", "page=2"]
            if !components.isEmpty, components.count >= 2 {
                let endpointString = components[0]
                // endpointString: character
                let queryItemsString = components[1]
                // queryItemsString: page=2
                // value=name&value=name
                let queryItems: [URLQueryItem] = queryItemsString.components(separatedBy: "&").compactMap({
                    guard $0.contains("=") else {
                        return nil
                    }
                    let parts = $0.components(separatedBy: "=")
                    // parts: ["page", "2"]

                    return URLQueryItem(
                        name: parts[0],
                        value: parts[1]
                    )
                })

                if let rmEndpoint = RMEndpoint(rawValue: endpointString) {
                    self.init(endpoint: rmEndpoint, queryParameters: queryItems)
                    return
                }
            }
        }

        return nil
    }
}

// MARK: - Request convenience

extension RMRequest {
    static let listCharactersRequests = RMRequest(endpoint: .character)
    static let listEpisodesRequest = RMRequest(endpoint: .episode)
    static let listLocationsRequest = RMRequest(endpoint: .location)
}
