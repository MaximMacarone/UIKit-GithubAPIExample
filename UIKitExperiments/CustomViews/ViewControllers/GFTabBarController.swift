//
//  GFTabBarController.swift
//  UIKitExperiments
//
//  Created by Maxim Makarenkov on 11.02.2025.
//

import UIKit

class GFTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureTabBarAppearance()
    }
    
    private func configureTabBarAppearance() {
        let tabItemFontAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12, weight: .regular, width: .expanded)]
        tabBar.tintColor = .systemIndigo
        UITabBarItem.appearance(whenContainedInInstancesOf: [GFTabBarController.self])
            .setTitleTextAttributes(tabItemFontAttributes, for: .normal)
    }

}
