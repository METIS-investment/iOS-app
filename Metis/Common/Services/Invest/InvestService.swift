//
//  InvestService.swift
//  Metis
//
//  Created by Veronika Zelinkova on 21.10.2023.
//

import Networking

final class InvestService: InvestServicing {
    var apiManager: APIManaging

    init(apiManager: APIManaging) {
        self.apiManager = apiManager
    }

    func investReccuring(model: RecurringInvestValueModel) async throws {
        try await apiManager.request(InvestRouter.postRecurringInvetment(model))
    }

    func investOneTime(model: InvestValueModel) async throws {
        try await apiManager.request(InvestRouter.postInvestment(model))
    }

    func setupPayment() async throws {
        try await apiManager.request(InvestRouter.postPayment(.init()))
    }

    func isUserBillable() async throws {
        try await apiManager.request(InvestRouter.isBillable)
    }
}
