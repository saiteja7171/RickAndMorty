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
    
    enum RMServiceError: Error {
        case failedURLRequest
        case failedToGetData
        case invalidURL
        case decodingFailed
    }
    
    public func execute<T: Codable>(_ request: RMRequest, expecting type: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        guard let urlRequest = self.request(from: request) else {
            completion(.failure(RMServiceError.failedURLRequest))
            return
        }
        let task = URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? RMServiceError.failedToGetData))
                return
            }
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(RMServiceError.decodingFailed))
            }
        }
        task.resume()
    }
    
    private func request(from rmRequest: RMRequest) -> URLRequest? {
        guard let url = rmRequest.url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        return request
    }
}
