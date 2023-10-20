//
//  StoriesStore.swift
//  Metis
//
//  Created by Veronika Zelinkova on 20.10.2023.
//

import Combine
import Foundation

final class StoriesStore: PublishingStore, ObservableObject {
    // MARK: - Public properties

    typealias State = StoriesState
    typealias Action = StoriesAction

    @Published private(set) var state: State = .initial

    // MARK: - Private properties

    private let eventSubject: PassthroughSubject<StoriesViewEvent, Never> = .init()

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

extension StoriesStore: EventEmitting {
    var eventPublisher: AnyPublisher<StoriesViewEvent, Never> {
        eventSubject.eraseToAnyPublisher()
    }
}

// MARK: - Private Methods

private extension StoriesStore {
    func fetchViewData() {
        Task { [weak self] in
            do {
                let data = StoriesViewData()
                self?.sendToMainActor(action: .didReceiveData(data: data))
            } catch {
                self?.sendToMainActor(action: .didReceiveError(error: error))
            }
        }
    }
}
