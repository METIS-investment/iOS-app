//
//  ProfileAction.swift
//  Metis
//
//  Created by Veronika Zelinkova on 20.10.2023.
//

import Foundation

enum ProfileAction {
    case viewDidLoad
    case didReceiveData(data: ProfileViewData)
    case didReceiveError(error: Error)
}
