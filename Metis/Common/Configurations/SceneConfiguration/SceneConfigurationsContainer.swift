//
//  SceneConfigurationsContainer.swift
//  Metis
//
//  Created by Veronika Zelinkova on 20.10.2023.
//

struct SceneConfigurationsContainer {
    private enum CodingKeys: String, CodingKey {
        case applicationScenes = "UIWindowSceneSessionRoleApplication"
        case externalDisplayScenes = "UIWindowSceneSessionRoleExternalDisplay"
    }

    let applicationScenes: [SceneConfiguration]
    let externalDisplayScenes: [SceneConfiguration]

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        applicationScenes = try values.decode([SceneConfiguration].self, forKey: .applicationScenes)
        externalDisplayScenes = try values.decodeIfPresent([SceneConfiguration].self, forKey: .externalDisplayScenes) ?? []
    }
}

// MARK: - Decodable

extension SceneConfigurationsContainer: Decodable {}
