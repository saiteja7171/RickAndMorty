//
//  RMCharacterDetailViewModel.swift
//  RickAndMorty
//
//  Created by Sai Teja Atluri on 9/30/25.
//

import UIKit

final class RMCharacterDetailviewViewModel {
    private let character: RMCharacter
    
    public var episodes: [String] {
        character.episode
    }
    
    enum SectionType {
        case picture(viewModel: RMCharacterPhotoCollectionViewCellViewModel)
        case information(viewModels: [RMCharacterInfoCollectionViewCellViewModel] )
        case episodes(viewModels: [RMCharacterEpisodeCollectionViewCellViewModel])
    }
    
    public var sections:[SectionType] = []
    init(character: RMCharacter) {
        self.character = character
        setUpSections()
    }
    
    private func setUpSections() {
          sections = [
            .picture(viewModel: RMCharacterPhotoCollectionViewCellViewModel.init(imageURL: URL(string: character.image))),
            .information(viewModels: [
                .init(type: .status, value: character.status.rawValue),
                .init(type: .gender, value: character.gender.rawValue),
                .init(type: .type, value: character.type.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? "None": character.type),
                .init(type: .species, value: character.species),
                .init(type: .origin, value: character.origin.name),
                .init(type: .location, value: character.location.name),
                .init(type: .created, value: character.created),
                .init(type: .episodeCount, value: "\(character.episode.count)"),
                ]),
            .episodes(viewModels: character.episode.compactMap ({
                return RMCharacterEpisodeCollectionViewCellViewModel(episodeUrl: URL(string: $0))
            }))
        ]
    }
    
    private var requestURL: URL? {
        return URL(string: character.url)
    }
    public var title: String {
        character.name.uppercased()
    }
    
    // MARK: - Layouts
    
    public func createPhotoSectionLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 6, bottom: 10, trailing: 6)
        let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.5)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    public func createInfoSectionLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .absolute(150)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 6, trailing: 0)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(150)), subitem: item, count: 2)
        group.interItemSpacing = .fixed(6)
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 0, leading: 6, bottom: 6, trailing: 6)
        return section
    }
    
    public func createEpisodeSectionLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .absolute(350), heightDimension: .absolute(140)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0)
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(
                widthDimension: .absolute(350),
                heightDimension: .absolute(140)
            ),
            subitems: [item]
        )
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.interGroupSpacing = 12
        section.contentInsets = .init(top: 0, leading: 6, bottom: 6, trailing: 6)
        return section
    }
    
}
