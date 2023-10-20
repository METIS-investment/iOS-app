//
//  SignInStore.swift
//  Metis
//
//  Created by Veronika Zelinkova on 20.10.2023.
//

import Combine
import Firebase
import Foundation
import GoogleSignIn

final class SignInStore: PublishingStore, ObservableObject {
    // MARK: - Public properties

    typealias State = SignInState
    typealias Action = SignInAction

    @Published private(set) var state: State = .initial

    // MARK: - Private properties

    private let eventSubject: PassthroughSubject<SignInViewEvent, Never> = .init()

    // MARK: - Store methods

    var publisher: AnyPublisher<State, Never> {
        $state.eraseToAnyPublisher()
    }

    func send(action: Action) {
        switch action {
        case .viewDidLoad:
            fetchViewData()

        case let .didReceiveData(data):
            state = state
                .updating(\.data, with: data)
                .updating(\.error, with: nil)
                .updating(\.status, with: .ready)

        case let .didReceiveError(error):
            state = state
                .updating(\.error, with: error)
                .updating(\.status, with: .ready)

        case .didFinishSignIn:
            eventSubject.send(.finished)
        }
    }
}

// MARK: - Event Emitting

extension SignInStore: EventEmitting {
    var eventPublisher: AnyPublisher<SignInViewEvent, Never> {
        eventSubject.eraseToAnyPublisher()
    }
}

// MARK: - Private Methods

private extension SignInStore {
    func fetchViewData() {
        Task { [weak self] in
            do {
                let data = SignInViewData()
                self?.sendToMainActor(action: .didReceiveData(data: data))
            } catch {
                self?.sendToMainActor(action: .didReceiveError(error: error))
            }
        }
    }

    func signIn() {}
}
