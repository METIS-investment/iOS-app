//
//  ReactiveViewControllerProtocol.swift
//  Metis
//
//  Created by Veronika Zelinkova on 20.10.2023.
//

import Combine

/// Protocol defining publishers for all common view controller life cycle events
protocol ReactiveViewControllerProtocol {
    var viewDidLoadPublisher: AnyPublisher<Void, Never> { get }
    var viewWillAppearPublisher: AnyPublisher<Void, Never> { get }
    var viewDidAppearPublisher: AnyPublisher<Void, Never> { get }
    var viewWillDisappearPublisher: AnyPublisher<Void, Never> { get }
    var viewDidDisappearPublisher: AnyPublisher<Void, Never> { get }
}
