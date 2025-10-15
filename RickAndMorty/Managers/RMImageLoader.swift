//
//  RMImageLoader.swift
//  RickAndMorty
//
//  Created by Sai Teja Atluri on 10/13/25.
//

import Foundation
final class RMImageLoader {
    static let shared = RMImageLoader()
    
    private var imageLoader = NSCache<NSString, NSData>()
    
    private init() {}
    
    public func loadImage(_ url: URL) async throws -> Data {
        let key = url.absoluteString as NSString
        // Cache hit
        if let cachedData = imageLoader.object(forKey: key) {
            return cachedData as Data
        }
        // Cache miss — fetch
        let request = URLRequest(url: url)
        let (data, response) = try await URLSession.shared.data(for: request)
        // Validate HTTP status
        if let http = response as? HTTPURLResponse, !(200..<300).contains(http.statusCode) {
            throw URLError(.badServerResponse)
        }
        // Store in cache
        let value = data as NSData
        imageLoader.setObject(value, forKey: key)
        return data
    }
}
