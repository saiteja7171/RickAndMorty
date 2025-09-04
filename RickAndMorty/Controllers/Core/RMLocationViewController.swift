//
//  RMLocationViewController.swift
//  RickAndMorty
//
//  Created by Sai Teja Atluri on 8/25/25.
//

import UIKit

final class RMLocationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Location"
        RMService.shared.execute(RMRequest.listLocationRequest, expecting: RMGetAllLocationResponse.self) { result in
            switch result {
            case .success(let model):
                print(model)
            case .failure(let error):
                print(error)
            }
        }
    }
}
 
