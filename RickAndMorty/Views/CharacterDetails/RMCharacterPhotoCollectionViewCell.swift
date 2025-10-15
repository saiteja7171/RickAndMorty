//
//  RMCharacterPhotoCollectionViewCell.swift
//  RickAndMorty
//
//  Created by Sai Teja Atluri on 10/12/25.
//

import UIKit

final class RMCharacterPhotoCollectionViewCell: UICollectionViewCell {
    static let identifier: String = "RMCharacterPhotoCollectionViewCell"
    private var imageTask: Task<Void, Never>?
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        addConstraints()
        setLayer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 8
        return image
    }()
    
    private func setLayer() {
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = false
        contentView.layer.shadowColor = UIColor.label.cgColor
        contentView.layer.shadowOffset = CGSize(width: -4, height: 4)
        contentView.layer.shadowOpacity = 0.3
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    public func configure(with viewModel: RMCharacterPhotoCollectionViewCellViewModel) {
        imageTask?.cancel()
        imageView.image = nil
        imageTask = Task { [weak self] in
            do {
                let data = try await viewModel.fetchImage()   // async/await API
                guard !Task.isCancelled else { return }
                await MainActor.run {
                    self?.imageView.image = UIImage(data: data)
                }
            } catch is CancellationError {
                // Task was cancelled (e.g. cell reused) — ignore silently
                return

            } catch {
                // Any other unexpected error
                print("❌ Unexpected image load error: \(error.localizedDescription)")
                await MainActor.run {
                    self?.imageView.image = UIImage(systemName: "xmark.circle")
                }
            }
        }
    }
}
