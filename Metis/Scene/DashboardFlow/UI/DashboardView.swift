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
                        Text("\(Int(store.state.invested / 100))€")
                            .foregroundColor(.black)
                            .font(.custom("Nunito-Bold", size: 40))

                        Spacer()

                        Text("+0%")
                            .foregroundColor(.orange)
                            .font(.custom("Nunito-Bold", size: 40))
                    }
                    .padding(.top, 3)

                    Text("Investment: \(Int(store.state.invested / 100))€")
                        .font(.custom("Nunito-Regular", size: 12))
                        .foregroundColor(.gray)

                    Text("Dividends: 0€")
                        .font(.custom("Nunito-Regular", size: 12))
                        .foregroundColor(.gray)

                    Button(action: {
                        store.send(action: .didTapInvest)
                    }, label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.black)

                            Text("Invest 100€".uppercased())
                                .foregroundColor(.white)
                                .font(.custom("Nunito-Bold", size: 20))
                                .padding(10)
                        }
                    })
                    .padding(.top, 20)

                    Text("Expected earnings")
                        .font(.custom("Nunito-Bold", size: 20))
                        .foregroundColor(.black)
                        .padding(.top, 40)

                    LineView(
                        data: [store.state.invested / 100, (store.state.invested / 100) * 1.05, (store.state.invested / 100) * 1.05 * 1.05, (store.state.invested / 100) * 1.05 * 1.05 * 1.05, (store.state.invested / 100) * 1.05 * 1.05 * 1.05 * 1.05],
                        style: .init(
                            backgroundColor: .clear,
                            accentColor: .tint,
                            gradientColor: .init(start: .tint, end: .green),
                            textColor: .black,
                            legendTextColor: .gray,
                            dropShadowColor: .white
                        )
                    )
                    .disabled(true)

                    HStack {
                        Text("now")
                            .font(.custom("Nunito-Regular", size: 12))
                            .foregroundColor(.gray)

                        Spacer()

                        Text("5 months")
                            .font(.custom("Nunito-Regular", size: 12))
                            .foregroundColor(.gray)
                    }
                    .padding([.leading, .trailing], 24)
                    .offset(y: 280)
                }
                .padding([.leading, .trailing], 24)
            }
        }
    }
}
