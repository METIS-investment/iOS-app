//
//  StoryboardReference+StoreContaining.swift
//  Metis
//
//  Created by Veronika Zelinkova on 20.10.2023.
//

import RswiftResources

// MARK: - Initial View Controller instantiation using Store

extension StoryboardReference where Self: InitialControllerContainer, Self.InitialController: StoreContaining {
    func instantiateInitialViewController(store: Self.InitialController.ViewStore) -> Self.InitialController {
        let viewController: Self.InitialController? = instantiateInitialViewController()

        viewController?.store = store

        // swiftlint:disable:next force_unwrapping
        return viewController!
    }
}
