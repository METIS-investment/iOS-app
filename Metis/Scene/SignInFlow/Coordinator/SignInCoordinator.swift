//
//  SignInCoordinator.swift
//  Metis
//
//  Created by Veronika Zelinkova on 20.10.2023.
//

import Combine
import DependencyInjection
import SwiftUI
import UIKit

final class SignInCoordinator {
    var childCoordinators = [Coordinator]()

    let container: Container

    lazy var navigationController = UINavigationController()

    private var cancellables = Set<AnyCancellable>()
    private let eventSubject = PassthroughSubject<SignInCoordinatorEvent, Never>()

    init(container: Container) {
        self.container = container
    }
}

// MARK: - ViewControllerCoordinator

extension SignInCoordinator: NavigationControllerCoordinator {
    func start() {
        let viewController = makeSignInViewController()
        viewController.navigationItem.backButtonTitle = ""
        navigationController.navigationBar.isHidden = true
        navigationController.pushViewController(viewController, animated: false)
    }
}

// MARK: - Events

extension SignInCoordinator: EventEmitting {
    var eventPublisher: AnyPublisher<SignInCoordinatorEvent, Never> {
        eventSubject.eraseToAnyPublisher()
    }
}

// MARK: - View Controller Factory

extension SignInCoordinator {
    func makeSignInViewController() -> UIViewController {
        let store = resolve(SignInStore.self)
        let viewController = R.storyboard.signInViewController.instantiateInitialViewController(
            store: store
        )

        store.eventPublisher
            .sink { [weak self] event in
                self?.handle(event: event)
            }
            .store(in: &cancellables)

        return viewController
    }
}

// MARK: - Handle events

private extension SignInCoordinator {
    func handle(event _: SignInViewEvent) {}
}
