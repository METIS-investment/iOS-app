//
//  ReactiveViewController.swift
//  Metis
//
//  Created by Veronika Zelinkova on 20.10.2023.
//

import Combine
import UIKit

/// Combine-friendly superclass for view controllers
///
/// Oftentimes, we need to provide the view model's transform function with a view controller life cycle publisher on the input.
/// This convenience class provides you with publishers for all common life cycle events, namely `viewDidLoad`, `viewWillAppear`, `viewDidAppear`, `viewWillDisappear` and `viewDidDisappear`
class ReactiveViewController: UIViewController, ReactiveViewControllerProtocol {
    let viewDidLoadSubject = PassthroughSubject<Void, Never>()
    var viewDidLoadPublisher: AnyPublisher<Void, Never> { viewDidLoadSubject.eraseToAnyPublisher() }

    let viewWillAppearSubject = PassthroughSubject<Void, Never>()
    var viewWillAppearPublisher: AnyPublisher<Void, Never> { viewWillAppearSubject.eraseToAnyPublisher() }

    let viewDidAppearSubject = PassthroughSubject<Void, Never>()
    var viewDidAppearPublisher: AnyPublisher<Void, Never> { viewDidAppearSubject.eraseToAnyPublisher() }

    let viewWillDisappearSubject = PassthroughSubject<Void, Never>()
    var viewWillDisappearPublisher: AnyPublisher<Void, Never> { viewWillDisappearSubject.eraseToAnyPublisher() }

    let viewDidDisappearSubject = PassthroughSubject<Void, Never>()
    var viewDidDisappearPublisher: AnyPublisher<Void, Never> { viewDidDisappearSubject.eraseToAnyPublisher() }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewDidLoadSubject.send(())
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewWillAppearSubject.send(())
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewDidAppearSubject.send(())
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewWillDisappearSubject.send(())
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewDidDisappearSubject.send(())
    }
}
