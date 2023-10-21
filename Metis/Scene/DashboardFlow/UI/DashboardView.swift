//
//  DashboardView.swift
//  Metis
//
//  Created by Veronika Zelinkova on 20.10.2023.
//

import SwiftUI
import SwiftUICharts

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
                    .padding(.top, 20)

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

                    Text("Prediction")
                        .font(.custom("Nunito-Bold", size: 20))
                        .foregroundColor(.black)
                        .padding(.top, 50)

                    LineView(data: [8, 23, 54, 32, 12, 37, 7, 23, 43], style: .init(backgroundColor: .clear, accentColor: .tint, gradientColor: .init(start: .tint, end: .yellow), textColor: .black, legendTextColor: .gray, dropShadowColor: .white))
                }
            }
            .padding([.leading, .trailing], 24)
        }
    }
}
