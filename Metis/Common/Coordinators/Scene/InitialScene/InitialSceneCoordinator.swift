//
//  InitialSceneCoordinator.swift
//  Metis
//
//  Created by Veronika Zelinkova on 20.10.2023.
//

import Combine
import DependencyInjection
import UIKit

final class InitialSceneCoordinator {
    var childCoordinators = [Coordinator]()

    let container: Container

    private let window: UIWindow
    private var cancellables = Set<AnyCancellable>()

    init(window: UIWindow, container: Container) {
        self.window = window
        self.container = container
    }
}

// MARK: - SceneCoordinating

extension InitialSceneCoordinator: InitialSceneCoordinating {
    func start() {
        let coordinator = makeSignInView()
        childCoordinators.append(coordinator)
        coordinator.start()
        window.rootViewController = coordinator.rootViewController
        window.makeKeyAndVisible()
    }
}

// MARK: - Handle events

private extension InitialSceneCoordinator {
    func handle(event: MainTabBarCoordinatorEvent) {
        switch event {
        case .logout:
            let coordinator = makeSignInView()
            childCoordinators = []
            childCoordinators.append(coordinator)
            coordinator.start()
            window.rootViewController = coordinator.rootViewController
            window.makeKeyAndVisible()
        }
    }

    func handle(event: SignInCoordinatorEvent) {
        switch event {
        case .finished:
            let coordinator = makeTabBarView()
            childCoordinators = []
            childCoordinators.append(coordinator)
            coordinator.start()
            window.rootViewController = coordinator.rootViewController
            window.makeKeyAndVisible()
        }
    }
}

// MARK: - Factories

private extension InitialSceneCoordinator {
    func makeTabBarView() -> MainTabBarCoordinator {
        let coordinator = MainTabBarCoordinator(container: container)

        coordinator.eventPublisher
            .sink { [weak self] event in
                self?.handle(event: event)
            }
            .store(in: &cancellables)

        return coordinator
    }

    func makeSignInView() -> SignInCoordinator {
        let coordinator = SignInCoordinator(container: container)

        coordinator.eventPublisher
            .sink { [weak self] event in
                self?.handle(event: event)
            }
            .store(in: &cancellables)

        return coordinator
    }
}
