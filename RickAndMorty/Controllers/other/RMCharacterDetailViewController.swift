//
//  RMCharacterDetailViewController.swift
//  RickAndMorty
//
//  Created by Sai Teja Atluri on 9/30/25.
//

import UIKit

class RMCharacterDetailViewController: UIViewController {

    private let viewModel: RMCharacterDetailviewViewModel
    
    init(viewModel: RMCharacterDetailviewViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = viewModel.title
    }
    

    

}
