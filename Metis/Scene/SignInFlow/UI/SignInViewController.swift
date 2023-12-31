//
//  SignInViewController.swift
//  Metis
//
//  Created by Veronika Zelinkova on 20.10.2023.
//

import Combine
import Firebase
import FirebaseAuth
import FirebaseCore
import GoogleSignIn
import UIKit

enum Constants {
    static var accessToken: String = ""
}

final class SignInViewController: ReactiveViewController, StoreContaining {
    // MARK: - UI Components

    @IBOutlet private var signInButton: GIDSignInButton!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var descriptionLabel: UILabel!

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

        GIDSignIn.sharedInstance.signIn(withPresenting: self) { [weak self] result, error in
            if error != nil {
                self?.store.send(action: .didReceiveError(error: error!))
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

            Auth.auth().currentUser?.getIDTokenResult(forcingRefresh: true, completion: { idToken, _ in
                Constants.accessToken = idToken?.token ?? ""
            })

            Auth.auth().signIn(with: credential) { _, _ in
                self?.store.send(action: .didTapSignIn(.init(
                    first_name: user.profile?.givenName ?? "",
                    second_name: user.profile?.familyName ?? "",
                    birthdate: "2004-02-07 00:00:00.000000",
                    country: "",
                    street: "",
                    city: "",
                    zip_code: 10000
                )))
            }
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

        titleLabel.font = UIFont(name: "Nunito-Bold", size: 40)
        titleLabel.textColor = .black
        descriptionLabel.font = UIFont(name: "Nunito-Regular", size: 15)

        signInButton.colorScheme = .light
    }

    func bindToStore() {}
}
