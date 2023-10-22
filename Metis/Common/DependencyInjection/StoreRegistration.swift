//
//  StoreRegistration.swift
//  Metis
//
//  Created by Veronika Zelinkova on 20.10.2023.
//

import DependencyInjection

enum StoreRegistration {
    static func registerDependencies(to container: Container) {
        container.autoregister(
            in: .new, initializer: DashboardStore.init(investService:)
        )

        container.autoregister(
            in: .new, initializer: StoriesStore.init
        )

        container.autoregister(
            in: .new, initializer: ProfileStore.init
        )

        container.autoregister(
            in: .new, initializer: SignInStore.init(userService:)
        )
    }
}
