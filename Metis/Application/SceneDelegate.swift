//
//  SceneDelegate.swift
//  Metis
//
//  Created by Veronika Zelinkova on 20.10.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    // swiftlint:disable:next implicitly_unwrapped_optional
    weak var coordinator: InitialSceneCoordinator!

    func scene(_ scene: UIScene, willConnectTo _: UISceneSession, options _: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else {
            return
        }

        setupInitialScene(with: windowScene)
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        appCoordinator.didDisconnectScene(scene)
    }
}

// MARK: - Setup

private extension SceneDelegate {
    func setupInitialScene(with windowScene: UIWindowScene) {
        let window = UIWindow(windowScene: windowScene)
        window.tintColor = R.color.tintColor()
        self.window = window

        coordinator = appCoordinator.didLaunchScene(windowScene, window: window)

        coordinator.start()
    }
}
