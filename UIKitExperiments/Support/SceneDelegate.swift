//
//  SceneDelegate.swift
//  UIKitExperiments
//
//  Created by Maxim Makarenkov on 16.01.2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        configureNavBarAppearance()
        configureTabBarAppearance()
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        
        let tabBarController = createTabBarController()
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    
    func configureNavBarAppearance() {
        let navBarTitleAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .regular, width: .expanded)]
        let navBarLargeTitleAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 32, weight: .bold, width: .expanded)]
        
        UINavigationBar.appearance().prefersLargeTitles = true
        UINavigationBar.appearance().tintColor = .systemIndigo
        UINavigationBar.appearance().titleTextAttributes = navBarTitleAttributes
        UINavigationBar.appearance().largeTitleTextAttributes = navBarLargeTitleAttributes
    }
    
    private func configureTabBarAppearance() {
        let tabItemFontAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12, weight: .regular, width: .expanded)]
        UITabBar.appearance().tintColor = .systemIndigo
        
        UITabBarItem.appearance().setTitleTextAttributes(tabItemFontAttributes, for: .normal)
    }
    
    
    private func createSearchNavigationController() -> UIViewController {
        let vc = SearchViewController()
        vc.title = "Search"
        vc.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        
        return UINavigationController(rootViewController: vc)
    }
    
    private func createFavoritesNavigationController() -> UINavigationController {
        let vc = FavoritesViewController()
        vc.title = "Favorites"
        vc.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        
        return UINavigationController(rootViewController: vc)
    }
    
    private func createTabBarController() -> UITabBarController {
        let tabBarController = UITabBarController()
        
        let searchNavController = createSearchNavigationController()
        let favoritesNavController = createFavoritesNavigationController()
        
        tabBarController.viewControllers = [searchNavController, favoritesNavController]
        
        return tabBarController
    }


}

