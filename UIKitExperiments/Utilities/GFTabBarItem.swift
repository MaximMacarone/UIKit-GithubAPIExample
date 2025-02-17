//
//  GFTabBarItem.swift
//  UIKitExperiments
//
//  Created by Maxim Makarenkov on 11.02.2025.
//

import UIKit

enum GFTabTag: Int {
    case search
    case favorites
}

class GFTabBarItem: UITabBarItem {
    
    static func tabItem(tabBarSystemItem: UITabBarItem.SystemItem, tabTag: GFTabTag) -> UITabBarItem {
        return UITabBarItem(tabBarSystemItem: tabBarSystemItem, tag: tabTag.rawValue)
    }
}
