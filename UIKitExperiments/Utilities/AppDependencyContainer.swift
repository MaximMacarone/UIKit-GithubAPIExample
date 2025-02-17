//
//  AppDependencyContainer.swift
//  UIKitExperiments
//
//  Created by Maxim Makarenkov on 10.02.2025.
//

import UIKit

class AppDependencyContainer {
    
    // MARK: - Properties
    
}

fileprivate var tagCounter = 0
fileprivate let sharedNetworkService = GithubUserAPIService()

class DependencyFactory {
    
    // MARK: - Methods
    
    func makeSearchViewNavigationController() -> UINavigationController {
        let searchVC = SearchViewController(
            followerListViewModelFactory: self.makeFollowerListViewModel
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
            viewModel: viewModel
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
    
    func makeUITabBarItem(tabBarSystemItem: UITabBarItem.SystemItem) -> UITabBarItem {
        let tabBarItem = UITabBarItem(tabBarSystemItem: tabBarSystemItem, tag: tagCounter)
        tagCounter += 1
        return tabBarItem
    }
}


//private func createSearchNavigationController() -> UIViewController {
//    let vc = SearchViewController()
//    vc.title = "Search"
//    vc.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
//    
//    return UINavigationController(rootViewController: vc)
//}

//private func createFavoritesNavigationController() -> UINavigationController {
//    let vc = FavoritesViewController()
//    vc.title = "Favorites"
//    vc.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
//    
//    return UINavigationController(rootViewController: vc)
//}

//private func createTabBarController() -> UITabBarController {
//    let tabBarController = GFTabBarController()
//    
//    let searchNavController = createSearchNavigationController()
//    let favoritesNavController = createFavoritesNavigationController()
//    
//    tabBarController.viewControllers = [searchNavController, favoritesNavController]
//    
//    return tabBarController
//}
