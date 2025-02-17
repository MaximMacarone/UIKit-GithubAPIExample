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
        
        // MARK: - Containers
        
        let container = DependencyFactory()
        
        // MARK: - Navigation Controllers
        
        let searchViewNavigationController = container.makeSearchViewNavigationController()
        searchViewNavigationController.tabBarItem = container.makeUITabBarItem(tabBarSystemItem: .search)
        
        let favoritesViewController = container.makeFavoritesViewNavigationController()
        favoritesViewController.tabBarItem = container.makeUITabBarItem(tabBarSystemItem: .favorites)
        
        // MARK: - TabBar Controller
        
        let tabBarViewControllers = [
            searchViewNavigationController,
            favoritesViewController,
        ]
        
        let tabBarController = container.makeUITabBarController(
            viewControllers: tabBarViewControllers
        )
        
        // MARK: - Initiaization
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        
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

}

