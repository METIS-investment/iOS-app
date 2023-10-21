//
//  ServiceRegistration.swift
//  Metis
//
//  Created by Veronika Zelinkova on 20.10.2023.
//

import DependencyInjection

enum ServiceRegistration {
    static func registerDependencies(to container: Container) {
        container.autoregister(
            type: InvestServicing.self,
            in: .shared,
            initializer: InvestService.init(apiManager:)
        )
    }
}
