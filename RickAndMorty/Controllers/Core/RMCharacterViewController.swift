//
//  RMCharacterViewController.swift
//  RickAndMorty
//
//  Created by Sai Teja Atluri on 8/25/25.
//

import UIKit

final class RMCharacterViewController: UIViewController, RMCharacterListViewDelegate{
    
    private let characterListView = RMCharacterListView()
    override func viewDidLoad() {
        
        super.viewDidLoad()
        title = "Character"
        view.backgroundColor = .systemBackground
        setUpView()
    }
    
    func rmCharacterListView(_ view: RMCharacterListView, didSelectCharacter character: RMCharacter) {
        let viewModel = RMCharacterDetailviewViewModel(character: character)
        let detailVC = RMCharacterDetailViewController(viewModel: viewModel)
        detailVC.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    private func setUpView() {
        characterListView.delegate = self
        view.addSubviews(characterListView)
        NSLayoutConstraint.activate([
            characterListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            characterListView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            characterListView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            characterListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ])
    }
    
}
