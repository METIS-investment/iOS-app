//
//  SceneConfiguration.swift
//  Metis
//
//  Created by Veronika Zelinkova on 20.10.2023.
//

struct SceneConfiguration {
    private enum CodingKeys: String, CodingKey {
        case name = "UISceneConfigurationName"
        case delegateClassName = "UISceneDelegateClassName"
    }

    let delegateClassName: String
    let name: String
}

// MARK: - Decodable

extension SceneConfiguration: Decodable {}

// MARK: - Hashable

extension SceneConfiguration: Hashable {}
