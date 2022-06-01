//
//  AppView.swift
//  EierML-ios
//
//  Created by Torben Köhler on 05.07.21.
//

import SwiftUI
import ComposableArchitecture

struct AppView: View {
    var store: Store<AppState, AppAction>

    var body: some View {
        WithViewStore(self.store) { viewStore in
            ZStack {
                background
                VStack {
                    HStack {
                        Button {
                            print("")
                        } label: {
                            Image(systemName: "ellipsis")
                        }
                        .buttonStyle(RoundButton())
                        Spacer()
                        Text("EierML")
                            .font(.system(size: 27, weight: .bold, design: .default))
                            .foregroundColor(.white)
                        Spacer()
                        Button {
                            print("")
                        } label: {
                            Image(systemName: "heart.text.square")
                        }
                        .buttonStyle(RoundButton())
                    }
                    .padding(.init(top: 10, leading: 20, bottom: 0, trailing: 20))
                    Spacer()
                    Text("Hello EierML-App")
                    Spacer()
                }
                switch viewStore.currentPage {
                case .settings:
                    Text("Settings")
                case .articles:
                    Text("Articles")
                default: EmptyView()
                }
            }
        }
    }

    var background: some View {
        Group {
            Color.primary.colorInvert()
            LinearGradient(colors: [
                Color(red: 0.384, green: 0.596, blue: 0.875, opacity: 0.7),
                Color(red: 0.941, green: 0.369, blue: 0.392, opacity: 0.7)
            ], startPoint: .top, endPoint: .bottom)
        }
        .ignoresSafeArea()
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        AppView(store: .init(
            initialState: .init(currentPage: .main),
            reducer: appReducer,
            environment: ()
        ))
        AppView(store: .init(
            initialState: .init(currentPage: .main),
            reducer: appReducer,
            environment: ()
        ))
            .preferredColorScheme(.dark)
    }
}

// background: linear-gradient(180deg, rgba(98, 152, 223, 0.7) 0%, rgba(240, 94, 100, 0.7) 100%);
