//
//  SignInAction.swift
//  Metis
//
//  Created by Veronika Zelinkova on 20.10.2023.
//

import Foundation

enum SignInAction {
    case viewDidLoad
    case didReceiveData(data: SignInViewData)
    case didReceiveError(error: Error)
    case didTapSignIn
}
