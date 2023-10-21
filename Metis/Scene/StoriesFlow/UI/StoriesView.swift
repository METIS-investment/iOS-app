//
//  StoriesView.swift
//  Metis
//
//  Created by Veronika Zelinkova on 20.10.2023.
//

import Kingfisher
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

private extension StoriesView {
    @ViewBuilder
    var contentView: some View {
        switch store.state.status {
        case .loading:
            ProgressView()
        case .ready:
            HStack {
                Spacer()
                Text("Featured Stories")
                    .foregroundColor(.black)
                    .font(.custom("Nunito-Bold", size: 20))
                    .padding(.top, 15)
                Spacer()
            }

            ScrollView {
                item(title: "Title", description: "description")
                item(title: "Title", description: "description")
                item(title: "Title", description: "description")
            }
            .scrollIndicators(.hidden)
            .padding([.leading, .trailing], 24)
            .padding(.top, 20)
        }
    }

    func item(title: String, description: String) -> some View {
        HStack(alignment: .center) {
            KFImage(URL(string: "https://cdn.vox-cdn.com/thumbor/kt9CNq-5C9fyesBCKIq8XYFq0KA=/0x0:6720x4480/1200x800/filters:focal(2823x1703:3897x2777)/cdn.vox-cdn.com/uploads/chorus_image/image/69163878/GettyImages_1248901260.0.jpg"))
                .resizable()
                .cornerRadius(15)
                .frame(width: 100, height: 100)

            VStack(alignment: .leading) {
                Text(title)
                    .font(.custom("Nunito-Bold", size: 20))
                    .padding(.bottom, 5)

                Text(description)
                    .font(.custom("Nunito-Regular", size: 18))
            }
            .padding(.leading, 15)

            Spacer()

            Button(action: {}, label: {
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            })
        }
    }
}
