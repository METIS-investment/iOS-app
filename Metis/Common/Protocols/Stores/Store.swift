//
//  Store.swift
//  Metis
//
//  Created by Veronika Zelinkova on 20.10.2023.
//

import Foundation

/// ``Store`` protocol describes requirements for objects that provide views with data
/// The name ``Store`` is inspired by Redux architecture.
/// You can perceive it as a view model from MVVM that exposes only a single state property and a send method.
///
/// The ``state`` property and ``send(action:)`` method are marked as ``@MainActor`` because we typically subscribe to changes of ``state`` and directly reflect it in UI, hence, the ``state`` should be isolated to the main thread.
/// As the ``state`` property should be updated only from the ``send(action:)`` method, the method itself is also ``@MainActor`` for the sake of convenience.
///
/// > Warning: Even though ``state`` and ``send(action:)`` are defined as ``@MainActor``, ``Store`` is not thread safe.
/// ``@MainActor`` compiler check works only as long as you stick with Swift Concurrency.
/// When you mix Swift Concurrency with the traditional GCD approach, the compile time main thread checks don't work.
/// Use either Swift Concurrency only or be careful from which dispatch queues you access ``send(action:)`` method and ``state`` property.
/// You can also explicitly define ``send(action:)`` method as `async` which protects you from calling it synchronously from a non-main dispatch queue but bear in mind that in that case you can't call it synchronously from anywhere. (Be careful with having two ``send(action:)`` functions with the same signature and one marked as `async`. That will confuse the compiler and lead to issues.)
///
/// > Warning: You should define ``state`` and ``send(action:)`` in the same block/extension of struct/class where you conform to the `Store` protocol in order to have them implicitly inferred as ``@MainActor``, otherwise, you have to explicitly annotate them as `@MainActor`.
/// > Check detailed explanation on [Hacking with Swift](https://www.hackingwithswift.com/quick-start/concurrency/understanding-how-global-actor-inference-works).

protocol Store {
    associatedtype State: StoreState
    associatedtype Action

    /// Object that fully captures current state of a scene
    @MainActor var state: State { get }

    /// This method should be called whenever any action takes place
    /// Each state update must preceded by an action
    ///
    /// - Parameter action: Action that took place
    @MainActor func send(action: Action)
}

extension Store {
    /// Since the `send` method is ``@MainActor`` the ``Store`` protocol provides this convenient method to dispatch any action to the ``@MainActor`
    ///
    /// - Parameter action: Action that took place
    func sendToMainActor(action: Action) {
        Task {
            await send(action: action)
        }
    }
}
