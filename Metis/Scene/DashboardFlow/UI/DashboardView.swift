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
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Spacer()
                    Text("My Portfolio")
                        .foregroundColor(.black)
                        .font(.custom("Nunito-Bold", size: 20))
                        .padding(.top, 15)
                    Spacer()
                }
                Spacer()
            }
        }
    }
}
