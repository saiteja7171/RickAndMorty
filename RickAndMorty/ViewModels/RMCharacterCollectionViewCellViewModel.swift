//
//  RMCharacterCollectionViewCellViewModel.swift
//  RickAndMorty
//
//  Created by Sai Teja Atluri on 9/4/25.
//

import UIKit
import Foundation

final class RMCharacterCollectionViewCellViewModel: Hashable, Equatable {
    public let characterName: String
    private let characterStatus: RMCharacterStatus
    private let characterImageURL: URL?

    init(characterName: String,
         characterStatus: RMCharacterStatus,
         characterImageURL: URL?) {
        self.characterName = characterName
        self.characterStatus = characterStatus
        self.characterImageURL = characterImageURL
    }

    public var characterStatusText: String {
        return "Status: \(characterStatus.text)"
    }

    // MARK: - Networking
    
//    public func fetchImage(completion: @escaping (Result<Data, Error>) -> Void ) {
//        guard let url = characterImageURL else {
//            completion(.failure(URLError(.badURL)))
//            return }
//        let request = URLRequest(url: url)
//        let task = URLSession.shared.dataTask(with: request) { data, response, error in
//            guard let data = data, error == nil else {
//                completion(.failure(URLError(.badServerResponse)))
//                return
//            }
//            completion(.success(data))
//        }
//        task.resume()
//    }
    
    public func fetchImage() async throws -> Data {
        guard let url = characterImageURL else {
            throw URLError(.badURL)
        }
        let request = URLRequest(url: url)
        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse,
              200..<300 ~= httpResponse.statusCode else {
            throw URLError(.badServerResponse)
        }
        return data
    }
    
    static func == (lhs: RMCharacterCollectionViewCellViewModel, rhs: RMCharacterCollectionViewCellViewModel) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(characterName)
        hasher.combine(characterStatus)
        hasher.combine(characterImageURL)
    }

}

