//
//  RMCharacterViewController.swift
//  RickAndMorty
//
//  Created by Sai Teja Atluri on 8/25/25.
//

import UIKit

final class RMCharacterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Character"
        view.backgroundColor = .systemBackground
        RMService.shared.execute(RMRequest.listCharatersRequest, expecting: RMGetAllCharacterResponse.self) { result in
            switch result {
            case .success(let model):
                print(String(describing: model))
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
}
