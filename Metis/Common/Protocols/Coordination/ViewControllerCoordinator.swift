//
//  ViewControllerCoordinator.swift
//  Metis
//
//  Created by Veronika Zelinkova on 20.10.2023.
//

import UIKit

/// A coordinator protocol which contains `rootViewController`.
/// UIViewController-based coordinators confirm to this.
/// Coordinators which handles transition inside custom content view controllers (view controllers with childVCs) should conform to this.
/// For `UINavigationController` or `UITabBarController` based coordinators, use `NavigationControllerCoordinator` or `TabBarControllerCoordinator` respectively

protocol ViewControllerCoordinator: Coordinator {
    var rootViewController: UIViewController { get }
}
