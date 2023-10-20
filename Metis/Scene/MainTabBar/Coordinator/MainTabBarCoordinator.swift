//
//  MainTabBarCoordinator.swift
//  Metis
//
//  Created by Veronika Zelinkova on 20.10.2023.
//

import Combine
import DependencyInjection
import UIKit

final class MainTabBarCoordinator {
    var childCoordinators = [Coordinator]()
    let container: Container

    private var cancellables = Set<AnyCancellable>()
    private let eventSubject = PassthroughSubject<MainTabBarCoordinatorEvent, Never>()
    private(set) lazy var tabBarController: UITabBarController = {
        let viewController = MainTabBarViewController()

        viewController.eventPublisher
            .sink { [weak self] event in
                self?.handle(event: event)
            }
            .store(in: &cancellables)

        return viewController
    }()

    init(container: Container) {
        self.container = container
    }
}

// MARK: - Start coordinator

extension MainTabBarCoordinator: TabBarControllerCoordinator {
    func start() {
        tabBarController.viewControllers = [
            makeDashboardFlow().rootViewController,
        ]
    }
}

// MARK: - Events

extension MainTabBarCoordinator: EventEmitting {
    var eventPublisher: AnyPublisher<MainTabBarCoordinatorEvent, Never> {
        eventSubject.eraseToAnyPublisher()
    }
}

// MARK: - Private methods

private extension MainTabBarCoordinator {
    func makeTabBarController() -> UITabBarController {
        let tabBarController = UITabBarController()
        return tabBarController
    }

    func makeDashboardFlow() -> ViewControllerCoordinator {
        let coordinator = DashboardCoordinator(container: container)

        childCoordinators.append(coordinator)
        coordinator.start()

        coordinator.rootViewController.tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(systemName: "magnifyingglass"),
            selectedImage: UIImage(systemName: "magnifyingglass")
        )

        return coordinator
    }

    /* func makeProfileFlow() -> ViewControllerCoordinator {
         let coordinator = ProfileCoordinator(container: container)

         childCoordinators.append(coordinator)
         coordinator.start()

         coordinator.rootViewController.tabBarItem = UITabBarItem(
             title: nil,
             image: UIImage(systemName: "person"),
             selectedImage: UIImage(systemName: "person")
         )

         return coordinator
     } */
}

private extension MainTabBarCoordinator {
    func handle(event _: MainTabBarViewEvent) {}
}
