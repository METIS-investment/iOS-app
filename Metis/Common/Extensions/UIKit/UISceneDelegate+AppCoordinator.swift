//
//  UISceneDelegate+AppCoordinator.swift
//  Metis
//
//  Created by Veronika Zelinkova on 20.10.2023.
//

import UIKit

extension UISceneDelegate {
    var appCoordinator: AppCoordinating {
        guard let delegate = UIApplication.shared.delegate as? AppCoordinatorContaining else {
            fatalError("Application delegate doesn't implement `AppCoordinatorDelegating` protocol")
        }

        return delegate.coordinator
    }
}
