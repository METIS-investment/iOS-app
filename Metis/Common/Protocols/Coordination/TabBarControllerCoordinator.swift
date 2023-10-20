//
//  TabBarControllerCoordinator.swift
//  Metis
//
//  Created by Veronika Zelinkova on 20.10.2023.
//

import UIKit

protocol TabBarControllerCoordinator: ViewControllerCoordinator {
    var tabBarController: UITabBarController { get }
}

extension TabBarControllerCoordinator {
    var rootViewController: UIViewController {
        tabBarController
    }
}
