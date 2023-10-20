//
//  StoriesCoordinator.swift
//  Metis
//
//  Created by Veronika Zelinkova on 20.10.2023.
//

import Combine
import DependencyInjection
import SwiftUI
import UIKit

final class StoriesCoordinator {
    var childCoordinators = [Coordinator]()

    let container: Container

    lazy var navigationController = UINavigationController()

    private var cancellables = Set<AnyCancellable>()
    private let eventSubject = PassthroughSubject<StoriesCoordinatorEvent, Never>()

    init(container: Container) {
        self.container = container
    }
}

// MARK: - ViewControllerCoordinator

extension StoriesCoordinator: NavigationControllerCoordinator {
    func start() {
        let viewController = makeStoriesViewController()
        viewController.navigationItem.backButtonTitle = ""
        navigationController.navigationBar.isHidden = true
        navigationController.pushViewController(viewController, animated: false)
    }
}

// MARK: - Events

extension StoriesCoordinator: EventEmitting {
    var eventPublisher: AnyPublisher<StoriesCoordinatorEvent, Never> {
        eventSubject.eraseToAnyPublisher()
    }
}

// MARK: - View Controller Factory

extension StoriesCoordinator {
    func makeStoriesViewController() -> UIViewController {
        let store = resolve(StoriesStore.self)
        let view = StoriesView(store: store)

        store.eventPublisher
            .sink { [weak self] event in
                self?.handle(event: event)
            }
            .store(in: &cancellables)

        return UIHostingController(rootView: view)
    }
}

// MARK: - Handle events

private extension StoriesCoordinator {
    func handle(event _: StoriesViewEvent) {}
}
