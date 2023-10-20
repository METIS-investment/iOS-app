//
//  SceneManifest.swift
//  Metis
//
//  Created by Veronika Zelinkova on 20.10.2023.
//

struct SceneManifest {
    private enum CodingKeys: String, CodingKey {
        case supportsMultipleScenes = "UIApplicationSupportsMultipleScenes"
        case configurations = "UISceneConfigurations"
    }

    let supportsMultipleScenes: Bool
    let configurations: SceneConfigurationsContainer
}

// MARK: - Decodable

extension SceneManifest: Decodable {}
