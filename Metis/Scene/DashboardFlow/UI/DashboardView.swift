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
                    Text("Value")
                        .font(.custom("Nunito-Regular", size: 15))
                        .foregroundColor(.gray)

                    HStack {
                        Text("5000$")
                            .foregroundColor(.black)
                            .font(.custom("Nunito-Bold", size: 40))

                        Spacer()

                        Text("+20%")
                            .foregroundColor(.green)
                            .font(.custom("Nunito-Bold", size: 40))
                    }
                    .padding(.top, 3)

                    Text("Investment: 4000$")
                        .font(.custom("Nunito-Regular", size: 12))
                        .foregroundColor(.gray)

                    Text("Dividends: 1000$")
                        .font(.custom("Nunito-Regular", size: 12))
                        .foregroundColor(.gray)

                    Button(action: {
                        store.send(action: .didTapInvest)
                    }, label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.black)

                            Text("Invest".uppercased())
                                .foregroundColor(.white)
                                .font(.custom("Nunito-Bold", size: 20))
                                .padding(10)
                        }
                    })
                    .padding(.top, 20)

                    Text("Prediction")
                        .font(.custom("Nunito-Bold", size: 20))
                        .foregroundColor(.black)
                        .padding(.top, 40)

                    LineView(
                        data: [8, 9, 11, 13, 15, 18, 21, 25, 34],
                        style: .init(
                            backgroundColor: .clear,
                            accentColor: .tint,
                            gradientColor: .init(start: .tint, end: .yellow),
                            textColor: .black,
                            legendTextColor: .gray,
                            dropShadowColor: .white
                        )
                    )
                    .disabled(true)
                }
            }
            .padding([.leading, .trailing], 24)
        }
    }
}
