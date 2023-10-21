//
//  InvestServicing.swift
//  Metis
//
//  Created by Veronika Zelinkova on 21.10.2023.
//

import Foundation

protocol InvestServicing {
    func investOneTime(model: InvestValueModel) async throws
    func investReccuring(model: RecurringInvestValueModel) async throws
}
