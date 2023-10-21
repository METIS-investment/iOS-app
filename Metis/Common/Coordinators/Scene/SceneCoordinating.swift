//
//  SceneCoordinating.swift
//  Metis
//
//  Created by Veronika Zelinkova on 20.10.2023.
//

import DependencyInjection
import UIKit

protocol SceneCoordinating: Coordinator {
    init(window: UIWindow, container: Container)
}
