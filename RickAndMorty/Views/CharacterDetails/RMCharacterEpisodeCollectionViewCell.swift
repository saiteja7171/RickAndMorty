//
//  RMCharacterEpisodeCollectionViewCell.swift
//  RickAndMorty
//
//  Created by Sai Teja Atluri on 10/12/25.
//

import UIKit

final class RMCharacterEpisodeCollectionViewCell: UICollectionViewCell {
    static let identifier: String = "RMCharacterEpisodeCollectionViewCell"
    
    private let seasonLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .regular)
        label.numberOfLines = 0
        return label
    }()

    private let airDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .light)
        label.numberOfLines = 0
        return label
    }()

    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //contentView.backgroundColor = .systemBackground
        contentView.layer.borderWidth = 2
        contentView.layer.borderColor = UIColor.systemBlue.cgColor
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
        contentView.addSubviews(seasonLabel, nameLabel, airDateLabel)
        constraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func constraints() {
        NSLayoutConstraint.activate([
            // Season (e.g., "S01E01")
            seasonLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            seasonLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            seasonLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -12),
            
            // Name (multi-line)
            nameLabel.topAnchor.constraint(equalTo: seasonLabel.bottomAnchor, constant: 6),
            nameLabel.leadingAnchor.constraint(equalTo: seasonLabel.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            
            // Air date (multi-line, usually short)
            airDateLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            airDateLabel.leadingAnchor.constraint(equalTo: seasonLabel.leadingAnchor),
            airDateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            
            // IMPORTANT: anchor bottom so the cell can self-size correctly
            airDateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        seasonLabel.text = nil
        nameLabel.text = nil
        airDateLabel.text = nil
    }
    
    public func configure(with viewModel: RMCharacterEpisodeCollectionViewCellViewModel) {
        viewModel.registerForData {[weak self] data in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.nameLabel.text = data.name
                self.airDateLabel.text = "Aired on " + data.air_date
                self.seasonLabel.text = "Episode " + data.episode
            }
        }
        viewModel.fetchEpisode()
    }
}
