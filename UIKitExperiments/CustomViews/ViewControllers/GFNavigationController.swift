//
//  GFNavigationController.swift
//  UIKitExperiments
//
//  Created by Maxim Makarenkov on 11.02.2025.
//

import UIKit

class GFNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureNavBarAppearance()
    }
    
    private func configureNavBarAppearance() {
        let navBarTitleAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .regular, width: .expanded)]
        let navBarLargeTitleAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 32, weight: .bold, width: .expanded)]
        
        navigationBar.prefersLargeTitles = true
        navigationBar.tintColor = .systemIndigo
        navigationBar.titleTextAttributes = navBarTitleAttributes
        navigationBar.largeTitleTextAttributes = navBarLargeTitleAttributes
    }

}
