//
//  ProfileView.swift
//  Metis
//
//  Created by Veronika Zelinkova on 20.10.2023.
//

import SwiftUI

struct ProfileView: View {
    @StateObject private var store: ProfileStore

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
            Text("ProfileView")
            /* if let pizzas = store.state.data?.pizzas, pizzas.isNotEmpty {
                 listView(for: pizzas)
             } else {
                 EmptyView(
                     title: LocalizedString.marketListEmptyViewTitle(),
                     description: LocalizedString.marketListEmptyViewDescription()
                 )
             } */
        }
    }
}

