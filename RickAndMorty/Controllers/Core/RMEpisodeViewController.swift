//
//  RMEpisodeViewController.swift
//  RickAndMorty
//
//  Created by Sai Teja Atluri on 8/25/25.
//

import UIKit

final class RMEpisodeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Episode"
        RMService.shared.execute(RMRequest.listEpisodesRequest, expecting: RMGetAllEpisodeResponse.self) { result in
            switch result {
            case .success(let model):
                print(model)
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
}
