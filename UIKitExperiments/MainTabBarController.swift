//
//  MainTabBarController.swift
//  UIKitExperiments
//
//  Created by Maxim Makarenkov on 09.02.2025.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    private var tagCounter = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        print(viewControllers?.count ?? -1)
    }
    
    func appendViewController(_ viewController: UIViewController, title: String, image: UIImage) {
        let tabBarItem = UITabBarItem(title: title, image: image, tag: tagCounter)
        viewController.tabBarItem = tabBarItem
        viewControllers?.append(viewController)
        tagCounter += 1
    }
    
    func appendViewController(_ viewController: UIViewController, systemTabBarItem: UITabBarItem.SystemItem) {
        let tabBarItem = UITabBarItem(tabBarSystemItem: systemTabBarItem, tag: tagCounter)
        viewController.tabBarItem = tabBarItem
        viewControllers?.append(viewController)
        tagCounter += 1

    }
    
}
