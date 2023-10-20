//
//  AppDelegate.swift
//  Metis
//
//  Created by Veronika Zelinkova on 20.10.2023.
//

import FirebaseCore
import GoogleSignIn
import UIKit

class AppDelegate: UIResponder, UIApplicationDelegate, AppCoordinatorContaining {
    // swiftlint:disable:next implicitly_unwrapped_optional
    var coordinator: AppCoordinating!

    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        coordinator = AppCoordinator()
        coordinator.start()

        setupFirebase()

        return true
    }

    func application(_: UIApplication, open url: URL, options _: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        GIDSignIn.sharedInstance.handle(url)
    }
}

// MARK: - UISceneSession Lifecycle

extension AppDelegate {
    func application(_: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options _: UIScene.ConnectionOptions) -> UISceneConfiguration {
        guard let name = Configuration.default.sceneManifest?.configurations.applicationScenes.first?.name else {
            fatalError("No scene configuration")
        }

        return UISceneConfiguration(name: name, sessionRole: connectingSceneSession.role)
    }
}

// MARK: - Setup

private extension AppDelegate {
    func setupFirebase() {
        FirebaseApp.configure()
    }
}
