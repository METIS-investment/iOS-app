//
//  ManagerRegistration.swift
//  Metis
//
//  Created by Veronika Zelinkova on 20.10.2023.
//

import DependencyInjection
import Networking

enum ManagerRegistration {
    static func registerDependencies(to container: Container) {
        container.autoregister(
            type: APIManaging.self,
            in: .shared,
            initializer: {
                let loggingInterceptor = LoggingInterceptor()
                return APIManager(
                    requestAdapters: [loggingInterceptor],
                    responseProcessors: [loggingInterceptor, StatusCodeProcessor()],
                    errorProcessors: [loggingInterceptor]
                )
            }
        )
    }
}
