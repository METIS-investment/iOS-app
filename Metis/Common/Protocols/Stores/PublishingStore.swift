//
//  PublishingStore.swift
//  Metis
//
//  Created by Veronika Zelinkova on 20.10.2023.
//

import Combine

/// ``Store`` that exposes ``publisher`` to publish values of its state
///
/// Typically, a store exposes its state through `@Published var state: State` property which is just enough.
///
/// ``PublishingStore`` is a convenience protocol for UIKit where the state updates are consumed through publishers.
/// ``PublishingStore`` exposes ``statePublisher`` to conveniently access publisher for single properties of the store state

protocol PublishingStore: Store {
    /// Publishes values of the store state
    var publisher: AnyPublisher<State, Never> { get }
}

extension PublishingStore {
    /// Property that exposes publishers for properties of ``State``
    ///
    /// You can subscribe to those properties like this:
    ///
    ///     struct State {
    ///         let isLoading: Bool
    ///     }
    ///
    ///     store
    ///         .statePublisher
    ///         .isLoading
    ///         .sink {...}
    ///
    var statePublisher: PropertyPublisher<State> {
        PropertyPublisher(publisher: publisher.eraseToAnyPublisher())
    }
}
