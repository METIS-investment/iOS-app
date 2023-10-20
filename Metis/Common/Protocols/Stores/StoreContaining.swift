//
//  StoreContaining.swift
//  Metis
//
//  Created by Veronika Zelinkova on 20.10.2023.
//

import Foundation

protocol StoreContaining: AnyObject {
    associatedtype ViewStore: Store

    // swiftlint:disable:next implicitly_unwrapped_optional
    var store: ViewStore! { get set }
}
