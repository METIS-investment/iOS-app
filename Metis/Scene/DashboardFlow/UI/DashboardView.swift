//
//  DashboardView.swift
//  Metis
//
//  Created by Veronika Zelinkova on 20.10.2023.
//

import SwiftUI

struct DashboardView: View {
    @StateObject private var store: DashboardStore

    init(store: DashboardStore) {
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

private extension DashboardView {
    @ViewBuilder
    var contentView: some View {
        switch store.state.status {
        case .loading:
            ProgressView()
        case .ready:
            HStack {
                Spacer()
                Text("My Portfolio")
                    .foregroundColor(.black)
                    .font(.custom("Nunito-Bold", size: 20))
                    .padding(.top, 15)
                Spacer()
            }

            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    HStack {
                        Text("5000$")
                            .foregroundColor(.black)
                            .font(.custom("Nunito-Bold", size: 40))

                        Text("invested")
                            .font(.custom("Nunito-Regular", size: 20))
                            .foregroundColor(.black)
                            .padding(.leading, 20)

                        Spacer()
                    }
                    .padding(.top, 30)

                    HStack {
                        Text("5$")
                            .foregroundColor(.black)
                            .font(.custom("Nunito-Bold", size: 25))

                        Text("monthly dividend")
                            .font(.custom("Nunito-Regular", size: 20))
                            .foregroundColor(.black)
                            .padding(.leading, 20)

                        Spacer()
                    }
                    .padding(.top, 10)
                }
            }
            .padding([.leading, .trailing], 24)
        }
    }
}
