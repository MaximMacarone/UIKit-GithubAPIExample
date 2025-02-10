//
//  FavoritesViewController.swift
//  UIKitExperiments
//
//  Created by Maxim Makarenkov on 08.02.2025.
//

import UIKit

class FavoritesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        configureTabItem()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureTabItem() {
        tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
    }

}
