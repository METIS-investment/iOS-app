//
//  StoriesAction.swift
//  Metis
//
//  Created by Veronika Zelinkova on 20.10.2023.
//

import Foundation

enum StoriesAction {
    case viewDidLoad
    case didReceiveData(data: StoriesViewData)
    case didReceiveError(error: Error)
}
