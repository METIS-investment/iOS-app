//
//  UserService.swift
//  Metis
//
//  Created by Veronika Zelinkova on 21.10.2023.
//

import Networking

final class UserService: UserServicing {
    var apiManager: APIManaging

    init(apiManager: APIManaging) {
        self.apiManager = apiManager
    }

    func getUser() async throws {
        try await apiManager.request(UserRouter.getUser)
    }

    func createUser(model: User) async throws {
        try await apiManager.request(UserRouter.createUser(model))
    }

    func signUpUser() async throws {
        try await apiManager.request(UserRouter.signUpUser)
    }
}
