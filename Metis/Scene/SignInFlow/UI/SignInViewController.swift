//
//  SignInViewController.swift
//  Metis
//
//  Created by Veronika Zelinkova on 20.10.2023.
//

import Combine
import FirebaseAuth
import FirebaseCore
import GoogleSignIn
import UIKit

final class SignInViewController: ReactiveViewController, StoreContaining {
    // MARK: - UI Components

    @IBOutlet private var signInButton: GIDSignInButton!

    // MARK: - Public Properties

    // swiftlint:disable:next implicitly_unwrapped_optional
    var store: SignInStore!

    // MARK: - Private Properties

    private var cancellables = Set<AnyCancellable>()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        initialize()

        store.send(action: .viewDidLoad)
    }
}

// MARK: - Actions

private extension SignInViewController {
    @objc func didTapSignIn() {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config

        GIDSignIn.sharedInstance.signIn(withPresenting: self) { [unowned self] result, error in
            if error != nil {
                store.send(action: .didReceiveError(error: error!))
                return
            }

            guard let user = result?.user,
                  let idToken = user.idToken?.tokenString
            else {
                return
            }

            let credential = GoogleAuthProvider.credential(
                withIDToken: idToken,
                accessToken: user.accessToken.tokenString
            )

            store.send(action: .didFinishSignIn)
        }
    }
}

// MARK: - Private Methods

private extension SignInViewController {
    func initialize() {
        setupUI()
        bindToStore()
    }

    func setupUI() {
        signInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
    }

    func bindToStore() {}
}
