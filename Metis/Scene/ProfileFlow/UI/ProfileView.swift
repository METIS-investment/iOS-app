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
            HStack {
                Spacer()
                Text("My Profile")
                    .foregroundColor(.black)
                    .font(.custom("Nunito-Bold", size: 20))
                    .padding(.top, 15)
                Spacer()
            }

            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
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
                    .padding(.top, 20)

                    Text(auth?.email ?? "")
                        .font(.custom("Nunito-Regular", size: 15))
                        .foregroundColor(.gray)
                        .padding(.top, 3)

                    HStack {
                        Text("Card information")
                            .font(.custom("Nunito-Bold", size: 20))
                            .foregroundColor(.black)

                        Spacer()
                        
                        if store.state.isBillable {
                            Button(action: {
                                store.send(action: .didTapRemoveCard)
                            }, label: {
                                Text("Remove")
                                    .font(.custom("Nunito-Regular", size: 12))
                                    .foregroundColor(.gray)
                            })
                        }
                    }
                    .padding(.top, 50)

                    if store.state.isBillable {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(LinearGradient(colors: [Color(R.color.tintColor.name), Color(R.color.tintColor.name), .green], startPoint: .topLeading, endPoint: .bottomTrailing))
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
                    } else {
                        Button(action: {
                            store.send(action: .didTapAddCard)
                        }, label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(.black)

                                Text("Add card".uppercased())
                                    .foregroundColor(.white)
                                    .font(.custom("Nunito-Bold", size: 20))
                                    .padding(10)
                            }
                        })
                        .padding(.top, 10)
                    }

                    Text("Transaction History")
                        .font(.custom("Nunito-Bold", size: 20))
                        .foregroundColor(.black)
                        .padding(.top, 50)

                    Text("You are eligible to withdraw your money on \(auth?.metadata.creationDate?.addingTimeInterval(365 * 24 * 60 * 60) ?? Date().addingTimeInterval(365 * 24 * 60 * 60))")
                        .font(.custom("Nunito-Regular", size: 15))
                        .foregroundColor(.gray)
                        .padding(.top, 3)

                    Text("Get Help")
                        .font(.custom("Nunito-Bold", size: 20))
                        .foregroundColor(.black)
                        .padding(.top, 50)
                }
            }
            .padding([.leading, .trailing], 24)
        }
    }
}
