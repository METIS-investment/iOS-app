//
//  Coordinator.swift
//  Metis
//
//  Created by Veronika Zelinkova on 20.10.2023.
//

import DependencyInjection

protocol Coordinator: AnyObject {
    var container: Container { get }
    var childCoordinators: [Coordinator] { get set }

    func start()
}

// MARK: - Dependency Injection

extension Coordinator {
    func resolve<Service>(_ serviceType: Service.Type) -> Service {
        container.resolve(type: serviceType)
    }

    func resolve<Service>(_ serviceType: Service.Type, argument: some Any) -> Service {
        container.resolve(type: serviceType, argument: argument)
    }

    func resolve<Service: StoreContaining>(_ serviceType: Service.Type, store: Service.ViewStore) -> Service? {
        let instance = resolve(serviceType)

        instance.store = store

        return instance
    }

    func release(coordinator: Coordinator) {
        childCoordinators.removeAll { $0 === coordinator }
    }
}
