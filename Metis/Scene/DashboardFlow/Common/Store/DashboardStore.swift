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
    private let investService: InvestServicing

    init(investService: InvestServicing) {
        self.investService = investService
    }

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

        case .didTapInvest:
            doOneTimeInvestment(value: 10000)

        case let .didFinishedOneTimeInvestment(value):
            eventSubject.send(.showToast("You successfully invested \(value)$"))
            // reload
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

    // cents
    func doOneTimeInvestment(value: Double) {
        Task { [weak self, investService] in
            do {
                let model = InvestValueModel(value: value)
                try await investService.investOneTime(model: model)
                self?.sendToMainActor(action: .didFinishedOneTimeInvestment(value: value))
            } catch {
                self?.sendToMainActor(action: .didReceiveError(error: error))
            }
        }
    }
}
