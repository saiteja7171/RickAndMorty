//
//  RMLoadingCollectionReusableView.swift
//  RickAndMorty
//
//  Created by Sai Teja Atluri on 10/6/25.
//

import UIKit

class RMFooterLoadingCollectionReusableView: UICollectionReusableView {
    
    static let identifier = "RMFooterLoadingCollectionReusableView"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews(spinner)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            spinner.widthAnchor.constraint(equalToConstant: 100),
            spinner.heightAnchor.constraint(equalToConstant: 100),
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor)])
    }
    
    public func startAnimating() {
        spinner.startAnimating()
    }
}
