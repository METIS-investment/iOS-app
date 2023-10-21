//
//  DashboardState.swift
//  Metis
//
//  Created by Veronika Zelinkova on 20.10.2023.
//

import Foundation

struct DashboardState: StoreState {
    enum Status {
        case loading
        case ready
    }

    static let initial = DashboardState()

    var status: Status = .loading
    var invested: Double = 0
    var error: Error?
}
