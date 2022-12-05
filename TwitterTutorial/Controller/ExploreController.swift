//
//  ExploreController.swift
//  TwitterTutorial
//
//  Created by Guowei Lv on 1.12.2022.
//

import UIKit

class ExploreController: UIViewController {

    // MARK: - Properties

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
        
        configureUI()
    }

    // MARK: - Helpers
    func configureUI() {
        view.backgroundColor = .white
        
        navigationItem.title = "Explore"
    }
}
