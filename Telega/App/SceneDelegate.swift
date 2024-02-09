//
//  SceneDelegate.swift
//  Telega
//
//  Created by Diyor Tursunov on 08/02/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        
        let viewController = MainFlowControllerFactory.make(dicontainer: DIContainer.shared)
       
        window.rootViewController = viewController
        self.window = window
        window.makeKeyAndVisible()
    }
}

