//
//  ProfileStore.swift
//  Metis
//
//  Created by Veronika Zelinkova on 20.10.2023.
//

import Combine
import Foundation

final class ProfileStore: PublishingStore, ObservableObject {
    // MARK: - Public properties

    typealias State = ProfileState
    typealias Action = ProfileAction

    @Published private(set) var state: State = .initial

    // MARK: - Private properties

    private let eventSubject: PassthroughSubject<ProfileViewEvent, Never> = .init()

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
        }
    }
}

// MARK: - Event Emitting

extension ProfileStore: EventEmitting {
    var eventPublisher: AnyPublisher<ProfileViewEvent, Never> {
        eventSubject.eraseToAnyPublisher()
    }
}

// MARK: - Private Methods

private extension ProfileStore {
    func fetchViewData() {
        Task { [weak self] in
            do {
                let data = ProfileViewData()
                self?.sendToMainActor(action: .didReceiveData(data: data))
            } catch {
                self?.sendToMainActor(action: .didReceiveError(error: error))
            }
        }
    }
}
