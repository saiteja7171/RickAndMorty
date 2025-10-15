    //
    //  RMCharacterInfoCollectionViewCell.swift
    //  RickAndMorty
    //
    //  Created by Sai Teja Atluri on 10/12/25.
    //

    import UIKit

    final class RMCharacterInfoCollectionViewCell: UICollectionViewCell {
        static let identifier: String = "RMCharacterInfoCollectionViewCell"
        
        private let valueLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = .systemFont(ofSize: 22, weight: .light)
            label.numberOfLines = 0
            label.lineBreakMode = .byWordWrapping
            label.setContentCompressionResistancePriority(.required, for: .vertical)
            label.setContentHuggingPriority(.defaultHigh, for: .vertical)
            return label
        }()
        
        private let titleLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = "Location"
            label.font = .systemFont(ofSize: 20, weight: .medium)
            label.textAlignment = .center
            return label
        }()
        
        private let iconImageView: UIImageView = {
            let icon = UIImageView()
            icon.translatesAutoresizingMaskIntoConstraints = false
            icon.contentMode = .scaleAspectFit
            icon.image = UIImage(systemName: "globe.americas")
            return icon
        }()
        
        private let titleContainerView: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = .secondarySystemBackground
            return view
        }()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            //contentView.backgroundColor = .secondarySystemBackground
            contentView.layer.cornerRadius = 8
            contentView.layer.masksToBounds = true
            contentView.addSubviews(titleContainerView, valueLabel, iconImageView)
            titleContainerView.addSubview(titleLabel)
            constraints()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        private func constraints() {
            NSLayoutConstraint.activate([
                titleContainerView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
                titleContainerView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
                titleContainerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
                titleContainerView.heightAnchor.constraint(equalTo: contentView.heightAnchor
                                                           , multiplier: 0.33),
                titleLabel.centerXAnchor.constraint(equalTo: titleContainerView.centerXAnchor),
                titleLabel.leadingAnchor.constraint(greaterThanOrEqualTo: titleContainerView.leadingAnchor, constant: 16),
                titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: titleContainerView.trailingAnchor, constant: -16),
                titleLabel.topAnchor.constraint(equalTo: titleContainerView.topAnchor, constant: 8),
                titleLabel.bottomAnchor.constraint(equalTo: titleContainerView.bottomAnchor, constant: -8),
                
                iconImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
                iconImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
                iconImageView.heightAnchor.constraint(equalToConstant: 30),
                iconImageView.widthAnchor.constraint(equalToConstant: 30),
                
                valueLabel.leftAnchor.constraint(equalTo: iconImageView.rightAnchor, constant: 10),
                valueLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
                valueLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
                valueLabel.bottomAnchor.constraint(equalTo: titleContainerView.topAnchor, constant: -10)
            ])
        }
        
        override func prepareForReuse() {
            super.prepareForReuse()
            valueLabel.text = nil
            iconImageView.image = nil
            titleLabel.text = nil
            iconImageView.tintColor = .label
            titleLabel.textColor = .label
        }
        
        public func configure(with viewModel: RMCharacterInfoCollectionViewCellViewModel) {
            valueLabel.text = viewModel.displayValue
            titleLabel.text = viewModel.title
            iconImageView.image = viewModel.iconImageView
            iconImageView.tintColor = viewModel.tintColor
            titleLabel.textColor = viewModel.tintColor
        }
    }
