//
//  SceneDelegate.swift
//  shinghaLib
//
//  Created by seongha shin on 2022/04/04.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        
        self.window = UIWindow(windowScene: scene)
        
        let rootViewController = UINavigationController()
        appCoordinator = AppCoordinator(navigationController: rootViewController)
        appCoordinator?.startView.accept(())
        
        self.window?.overrideUserInterfaceStyle = .light
        self.window?.rootViewController = rootViewController
        self.window?.makeKeyAndVisible()
    }
}

