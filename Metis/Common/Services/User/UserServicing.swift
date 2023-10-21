//
//  UserServicing.swift
//  Metis
//
//  Created by Veronika Zelinkova on 21.10.2023.
//

import Foundation

protocol UserServicing {
    func getUser() async throws
    func createUser(model: User) async throws
    func signUpUser() async throws
}
