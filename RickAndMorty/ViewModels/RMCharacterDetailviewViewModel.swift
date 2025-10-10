//
//  RMCharacterDetailViewModel.swift
//  RickAndMorty
//
//  Created by Sai Teja Atluri on 9/30/25.
//

import Foundation

final class RMCharacterDetailviewViewModel {
    private let character: RMCharacter
    
    init(character: RMCharacter) {
        self.character = character
    }
    
    public var title: String {
        character.name.uppercased()
    }
}
