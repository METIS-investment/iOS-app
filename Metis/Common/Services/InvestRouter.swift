//
//  InvestRouter.swift
//  Metis
//
//  Created by Veronika Zelinkova on 21.10.2023.
//

import Foundation
import Networking

enum InvestRouter {
    case postInvestment(InvestValueModel)
    case postRecurringInvetment(RecurringInvestValueModel)
}

extension InvestRouter: Requestable {
    var baseURL: URL {
        Configuration.default.apiBaseUrl
    }

    var path: String {
        switch self {
        case .postInvestment, .postRecurringInvetment:
            return "post"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .postInvestment, .postRecurringInvetment:
            return .post
        }
    }

    var dataType: RequestDataType? {
        switch self {
        case let .postInvestment(model):
            return .encodable(model)
        case let .postRecurringInvetment(model):
            return .encodable(model)
        }
    }
}
