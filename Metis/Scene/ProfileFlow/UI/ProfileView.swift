//
//  ProfileView.swift
//  Metis
//
//  Created by Veronika Zelinkova on 20.10.2023.
//

import FirebaseAuth
import SwiftUI

struct ProfileView: View {
    @StateObject private var store: ProfileStore

    private let auth = Auth.auth().currentUser

    init(store: ProfileStore) {
        _store = .init(wrappedValue: store)
    }

    var body: some View {
        contentView
            .onFirstAppear {
                store.send(action: .viewDidLoad)
            }
            .alert(isPresented: .constant(store.state.error != nil)) {
                Alert(
                    title: Text(LocalizedString.generalError()),
                    message: Text(store.state.error?.localizedDescription ?? ""),
                    dismissButton: .default(
                        Text(LocalizedString.generalOk())
                    )
                )
            }
    }
}

// MARK: - Private

private extension ProfileView {
    @ViewBuilder
    var contentView: some View {
        switch store.state.status {
        case .loading:
            ProgressView()
        case .ready:
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    HStack {
                        Spacer()
                        Text("My Profile")
                            .foregroundColor(.black)
                            .font(.custom("Nunito-Bold", size: 20))
                            .padding(.top, 15)
                        Spacer()
                    }

                    HStack(alignment: .bottom) {
                        Text(auth?.displayName ?? "Name")
                            .font(.custom("Nunito-Bold", size: 25))

                        Spacer()

                        Button(action: {
                            store.send(action: .didTapLogout)
                        }, label: {
                            Text("Logout")
                                .font(.custom("Nunito-Regular", size: 12))
                                .foregroundColor(.gray)
                        })
                        .offset(y: -5)
                    }
                    .padding(.top, 30)

                    Text(auth?.email ?? "")
                        .font(.custom("Nunito-Regular", size: 15))
                        .foregroundColor(.gray)
                        .padding(.top, 3)

                    HStack {
                        Text("Card information")
                            .font(.custom("Nunito-Bold", size: 20))
                            .foregroundColor(.black)

                        Spacer()

                        Button(action: {}, label: {
                            Text("Remove")
                                .font(.custom("Nunito-Regular", size: 12))
                                .foregroundColor(.gray)
                        })
                    }
                    .padding(.top, 50)

                    RoundedRectangle(cornerRadius: 20)
                        .fill(LinearGradient(colors: [Color(R.color.tintColor.name), Color(R.color.tintColor.name), .yellow], startPoint: .topLeading, endPoint: .bottomTrailing))
                        .opacity(0.5)
                        .frame(height: 200)
                        .padding(.top, 15)
                        .overlay {
                            VStack(spacing: 0) {
                                HStack {
                                    Text("VISA")
                                        .font(.custom("Nunito-Bold", size: 18))
                                        .foregroundColor(.black)

                                    Spacer()
                                }
                                .padding(.bottom, 100)

                                Text("****  ****  ****  1234")
                                    .font(.custom("Nunito-Bold", size: 20))
                                    .foregroundColor(.black)
                            }
                            .padding(.leading, 20)
                        }

                    Text("Transaction History")
                        .font(.custom("Nunito-Bold", size: 20))
                        .foregroundColor(.black)
                        .padding(.top, 50)
                }
                .padding([.leading, .trailing], 24)
            }
        }
    }
}
