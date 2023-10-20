//
//  StoriesView.swift
//  Metis
//
//  Created by Veronika Zelinkova on 20.10.2023.
//

import SwiftUI

struct StoriesView: View {
    @StateObject private var store: StoriesStore

    init(store: StoriesStore) {
        _store = .init(wrappedValue: store)
    }

    var body: some View {
        contentView
            .onFirstAppear {
                store.send(action: .viewDidLoad)
            }
        /* .alert(isPresented: .constant(store.state.error != nil)) {
             Alert(
                 title: Text(LocalizedString.generalError()),
                 message: Text(store.state.error?.localizedDescription ?? ""),
                 dismissButton: .default(
                     Text(LocalizedString.generalOk())
                 )
             )
         }*/
    }
}

// MARK: - Private

private extension StoriesView {
    @ViewBuilder
    var contentView: some View {
        switch store.state.status {
        case .loading:
            ProgressView()
        case .ready:
            Text("StoriesView")
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
