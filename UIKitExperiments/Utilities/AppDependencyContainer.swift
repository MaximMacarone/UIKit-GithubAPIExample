//
//  AppDependencyContainer.swift
//  UIKitExperiments
//
//  Created by Maxim Makarenkov on 10.02.2025.
//

import UIKit
import Combine

class AppDependencyContainer {
    
    // MARK: - Properties
    
}

fileprivate var tagCounter = 0
fileprivate let sharedNetworkService = GithubUserAPIService()

class DependencyFactory {
    
    // MARK: - Methods
    
    func makeSearchViewNavigationController() -> UINavigationController {
        let searchVC = SearchViewController(
            followerListVCFactory: self.makeFollowerListViewController
        )
        searchVC.title = "Search"
        let navigationController = GFNavigationController(rootViewController: searchVC)
        
        return navigationController
    }
    
    func makeFavoritesViewNavigationController() -> UINavigationController {
        let favoritesVC = FavoritesViewController()
        favoritesVC.title = "Favorites"
        let navigationController = GFNavigationController(rootViewController: favoritesVC)
        
        return navigationController
    }
    
    func makeFollowerListViewController(for username: String) -> FollowerListViewController {
        
        let viewModel = makeFollowerListViewModel(username: username)
        
        let followerListVC = FollowerListViewController(
            viewModel: viewModel, userInfoVCFactory: self.makeUserInfoViewController
        )
        followerListVC.title = "Followers"
        
        return followerListVC
    }
    
    func makeUITabBarController(
        viewControllers: [UIViewController]
    ) -> UITabBarController {
        let tabBarController = GFTabBarController()
        
        tabBarController.viewControllers = viewControllers
        
        return tabBarController
    }
    
    func makeFollowerListViewModel(username: String) -> FollowerListViewModel {
        let followerListVM = FollowerListViewModel(networkService: sharedNetworkService, username: username)
        
        return followerListVM
    }
    
    func makeUserInfoViewModel(username: String) -> UserInfoViewModel {
        let userInfoVM = UserInfoViewModel(username: username, networkService: sharedNetworkService)
        
        return userInfoVM
    }
    
    func makeUserInfoViewController(
        username: String
    ) -> UserInfoViewController {
        let userInfoVM = makeUserInfoViewModel(username: username)
        let userInfoVC = UserInfoViewController(viewModel: userInfoVM, userInfoHeaderVCFactory: makeUserInfoHeaderVC)
        
        return userInfoVC
    }
    
    func makeUITabBarItem(tabBarSystemItem: UITabBarItem.SystemItem) -> UITabBarItem {
        let tabBarItem = UITabBarItem(tabBarSystemItem: tabBarSystemItem, tag: tagCounter)
        tagCounter += 1
        return tabBarItem
    }
    
    func makeUserInfoHeaderVC(user: User) -> UserInfoHeaderViewController {
        return UserInfoHeaderViewController(user: user)
    }
    
}
