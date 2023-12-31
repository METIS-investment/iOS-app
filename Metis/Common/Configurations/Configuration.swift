//
//  Configuration.swift
//  Metis
//
//  Created by Veronika Zelinkova on 20.10.2023.
//

import Foundation

struct Configuration: Decodable {
    private enum CodingKeys: String, CodingKey {
        case apiBaseUrl = "API_BASE_URL"
        case sceneManifest = "UIApplicationSceneManifest"
    }

    let apiBaseUrl: URL
    let sceneManifest: SceneManifest?
}

// MARK: Static properties

extension Configuration {
    static let `default`: Configuration = {
        guard let propertyList = Bundle.main.infoDictionary else {
            fatalError("Unable to get property list.")
        }

        guard let data = try? JSONSerialization.data(withJSONObject: propertyList, options: []) else {
            fatalError("Unable to instantiate data from property list.")
        }

        let decoder = JSONDecoder()

        guard let configuration = try? decoder.decode(Configuration.self, from: data) else {
            fatalError("Unable to decode the Environment configuration file.")
        }

        return configuration
    }()
}
