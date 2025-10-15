//
//  RMCharacterPhotoCollectionViewCellViewModel.swift
//  RickAndMorty
//
//  Created by Sai Teja Atluri on 10/12/25.
//

import UIKit

final class RMCharacterPhotoCollectionViewCellViewModel {
    private var imageURL: URL?
    
    init(imageURL: URL?) {
        self.imageURL = imageURL
    }
     
    public func fetchImage() async throws -> Data {
        guard let imageURL = imageURL else { throw URLError(.badURL) }
        return try await RMImageLoader.shared.loadImage(imageURL)
    }
}
