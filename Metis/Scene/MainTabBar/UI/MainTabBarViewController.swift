//
//  MainTabBarViewController.swift
//  Metis
//
//  Created by Veronika Zelinkova on 20.10.2023.
//

import Combine
import UIKit

final class MainTabBarViewController: UITabBarController {
    // MARK: Private Properties

    private let eventSubject = PassthroughSubject<MainTabBarViewEvent, Never>()
    private var cancellables = Set<AnyCancellable>()

    // MARK: Lifecycle

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

// MARK: - Private Methods

private extension MainTabBarViewController {
    func setup() {}
}

// MARK: - Events

extension MainTabBarViewController: EventEmitting {
    var eventPublisher: AnyPublisher<MainTabBarViewEvent, Never> {
        eventSubject.eraseToAnyPublisher()
    }
}
