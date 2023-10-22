//
//  DashboardCoordinator.swift
//  Metis
//
//  Created by Veronika Zelinkova on 20.10.2023.
//

import Combine
import DependencyInjection
import SwiftUI
import UIKit

final class DashboardCoordinator {
    var childCoordinators = [Coordinator]()

    let container: Container

    lazy var navigationController = UINavigationController()

    private var cancellables = Set<AnyCancellable>()
    private let eventSubject = PassthroughSubject<DashboardCoordinatorEvent, Never>()

    init(container: Container) {
        self.container = container
    }
}

// MARK: - ViewControllerCoordinator

extension DashboardCoordinator: NavigationControllerCoordinator {
    func start() {
        let viewController = makeDashboardViewController()
        viewController.navigationItem.backButtonTitle = ""
        navigationController.navigationBar.isHidden = true
        navigationController.pushViewController(viewController, animated: false)
    }
}

// MARK: - Events

extension DashboardCoordinator: EventEmitting {
    var eventPublisher: AnyPublisher<DashboardCoordinatorEvent, Never> {
        eventSubject.eraseToAnyPublisher()
    }
}

// MARK: - View Controller Factory

extension DashboardCoordinator {
    func makeDashboardViewController() -> UIViewController {
        let store = resolve(DashboardStore.self)
        let view = DashboardView(store: store)

        store.eventPublisher
            .sink { [weak self] event in
                self?.handle(event: event)
            }
            .store(in: &cancellables)

        return UIHostingController(rootView: view)
    }
}

// MARK: - Handle events

private extension DashboardCoordinator {
    func handle(event: DashboardViewEvent) {
        switch event {
        case let .showToast(message):
            rootViewController.showToast(message: message)
        }
    }
}
