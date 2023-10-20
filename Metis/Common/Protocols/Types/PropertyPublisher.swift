//
//  PropertyPublisher.swift
//  Metis
//
//  Created by Veronika Zelinkova on 20.10.2023.
//

import Combine

/// ``PropertyPublisher`` is initialized with a publisher of any `Output` type and `Never` error type and through dot convention, it exposes publishers for all properties of `Output`
///
/// Let's assume we have the following structure:
///
///     struct State {
///         let isLoading: Bool
///     }
///
/// Then, you can use ``PropertyPublisher`` as follows:
///
///     let publisher: AnyPublisher<State, Never>
///     let propertyPublisher = PropertyPublisher(publisher: publisher)
///
///     propertyPublisher
///         .isLoading
///         .sink { ... }
///         .store(...)
///
@dynamicMemberLookup
struct PropertyPublisher<T> {
    let publisher: AnyPublisher<T, Never>

    subscript<Value>(dynamicMember member: KeyPath<T, Value>) -> AnyPublisher<Value, Never> {
        publisher
            .map(member)
            .eraseToAnyPublisher()
    }

    subscript<Value: Equatable>(dynamicMember member: KeyPath<T, Value>) -> AnyPublisher<Value, Never> {
        publisher
            .map(member)
            .removeDuplicates()
            .eraseToAnyPublisher()
    }
}
