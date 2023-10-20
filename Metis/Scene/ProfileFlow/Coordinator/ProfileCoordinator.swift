//
//  ProfileCoordinator.swift
//  Metis
//
//  Created by Veronika Zelinkova on 20.10.2023.
//

import Combine
import DependencyInjection
import SwiftUI
import UIKit

final class ProfileCoordinator {
    var childCoordinators = [Coordinator]()

    let container: Container

    lazy var navigationController = UINavigationController()

    private var cancellables = Set<AnyCancellable>()
    private let eventSubject = PassthroughSubject<ProfileCoordinatorEvent, Never>()

    init(container: Container) {
        self.container = container
    }
}

// MARK: - ViewControllerCoordinator

extension ProfileCoordinator: NavigationControllerCoordinator {
    func start() {
        let viewController = makeProfileViewController()
        viewController.navigationItem.backButtonTitle = ""
        navigationController.navigationBar.isHidden = true
        navigationController.pushViewController(viewController, animated: false)
    }
}

// MARK: - Events

extension ProfileCoordinator: EventEmitting {
    var eventPublisher: AnyPublisher<ProfileCoordinatorEvent, Never> {
        eventSubject.eraseToAnyPublisher()
    }
}

// MARK: - View Controller Factory

extension ProfileCoordinator {
    func makeProfileViewController() -> UIViewController {
        let store = resolve(ProfileStore.self)
        let view = ProfileView(store: store)

        store.eventPublisher
            .sink { [weak self] event in
                self?.handle(event: event)
            }
            .store(in: &cancellables)

        return UIHostingController(rootView: view)
    }
}

// MARK: - Handle events

private extension ProfileCoordinator {
    func handle(event _: ProfileViewEvent) {}
}

