//
//  StoriesState.swift
//  Metis
//
//  Created by Veronika Zelinkova on 20.10.2023.
//

import Foundation

struct StoriesState: StoreState {
    enum Status {
        case loading
        case ready
    }

    static let initial = StoriesState()

    var status: Status = .loading
    var data: StoriesViewData?
    var error: Error?
}
