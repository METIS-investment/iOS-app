//
//  SignInState.swift
//  Metis
//
//  Created by Veronika Zelinkova on 20.10.2023.
//

import Foundation

struct SignInState: StoreState {
    enum Status {
        case loading
        case ready
    }

    static let initial = SignInState()

    var status: Status = .loading
    var data: SignInViewData?
    var error: Error?
}
