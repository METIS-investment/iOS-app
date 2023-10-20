//
//  DashboardStore.swift
//  Metis
//
//  Created by Veronika Zelinkova on 20.10.2023.
//

import Combine
import Foundation

final class DashboardStore: PublishingStore, ObservableObject {
    // MARK: - Public properties

    typealias State = DashboardState
    typealias Action = DashboardAction

    @Published private(set) var state: State = .initial

    // MARK: - Private properties

    private let eventSubject: PassthroughSubject<DashboardViewEvent, Never> = .init()

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

extension DashboardStore: EventEmitting {
    var eventPublisher: AnyPublisher<DashboardViewEvent, Never> {
        eventSubject.eraseToAnyPublisher()
    }
}

// MARK: - Private Methods

private extension DashboardStore {
    func fetchViewData() {
        Task { [weak self] in
            do {
                let data = DashboardViewData()
                self?.sendToMainActor(action: .didReceiveData(data: data))
            } catch {
                self?.sendToMainActor(action: .didReceiveError(error: error))
            }
        }
    }
}
