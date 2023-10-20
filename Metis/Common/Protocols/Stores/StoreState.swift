//
//  StoreState.swift
//  Metis
//
//  Created by Veronika Zelinkova on 20.10.2023.
//

import Foundation

protocol StoreState {}

extension StoreState {
    func updating<Value>(_ keyPath: WritableKeyPath<Self, Value>, with value: Value) -> Self {
        var copy = self
        copy[keyPath: keyPath] = value
        return copy
    }
}
