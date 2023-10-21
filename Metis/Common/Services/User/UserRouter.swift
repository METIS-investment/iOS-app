//
//  UserRouter.swift
//  Metis
//
//  Created by Veronika Zelinkova on 21.10.2023.
//

import FirebaseAuth
import Foundation
import Networking

enum UserRouter {
    case getUser
    case createUser(User)
    case signUpUser
}

extension UserRouter: Requestable {
    var baseURL: URL {
        Configuration.default.apiBaseUrl
    }

    var path: String {
        switch self {
        case .getUser:
            return "details"
        case .createUser:
            return "signup"
        case .signUpUser:
            return "finish_signup"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .createUser, .signUpUser:
            return .post
        case .getUser:
            return .get
        }
    }

    var dataType: RequestDataType? {
        switch self {
        case let .createUser(model):
            return .encodable(model)
        case .signUpUser:
            return nil
        case .getUser:
            return nil
        }
    }

    var headers: [String: String]? {
        ["Authorization": "Bearer \(Constants.accessToken)"]
    }
}
