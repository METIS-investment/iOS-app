//
//  AppCoordinating.swift
//  Metis
//
//  Created by Veronika Zelinkova on 20.10.2023.
//

import UIKit

protocol AppCoordinating: Coordinator {
    func didLaunchScene<Coordinator: SceneCoordinating>(_ scene: UIScene, window: UIWindow) -> Coordinator
    func didDisconnectScene(_ scene: UIScene)
}
