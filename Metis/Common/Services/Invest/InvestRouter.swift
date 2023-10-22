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
    case postPayment(PaymentModel)
    case isBillable
}

extension InvestRouter: Requestable {
    var baseURL: URL {
        Configuration.default.apiBaseUrl
    }

    var path: String {
        switch self {
        case .postInvestment:
            return "one-time-investment"
        case .postRecurringInvetment:
            return "recurring-investment"
        case .postPayment:
            return "payment_method"
        case .isBillable:
            return "investment"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .postInvestment, .postRecurringInvetment, .postPayment:
            return .post
        case .isBillable:
            return .get
        }
    }

    var dataType: RequestDataType? {
        switch self {
        case let .postInvestment(model):
            return .encodable(model)
        case let .postRecurringInvetment(model):
            return .encodable(model)
        case let .postPayment(model):
            return .encodable(model)
        case .isBillable:
            return nil
        }
    }

    var headers: [String: String]? {
        print("AAAXXX token: \(Constants.accessToken)")
        return ["Authorization": "Bearer \(Constants.accessToken)"]
    }
}
