//
//  ProfileState.swift
//  Metis
//
//  Created by Veronika Zelinkova on 20.10.2023.
//

import Foundation

struct ProfileState: StoreState {
    enum Status {
        case loading
        case ready
    }

    static let initial = ProfileState()

    var status: Status = .loading
    var data: ProfileViewData?
    var error: Error?
}
