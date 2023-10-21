//
//  DashboardAction.swift
//  Metis
//
//  Created by Veronika Zelinkova on 20.10.2023.
//

import Foundation

enum DashboardAction {
    case viewDidLoad
    case didReceiveData(Double)
    case didReceiveError(error: Error)
    case didTapInvest
    case didFinishedOneTimeInvestment(value: Double)
}
