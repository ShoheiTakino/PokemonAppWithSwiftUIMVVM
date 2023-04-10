//
//  LaunchScreen.swift
//  PokemonAppWithSwiftUIMVVM
//
//  Created by 滝野翔平 on 2023/04/10.
//

import SwiftUI

struct LaunchScreen: View {
    @State private var isLoading = true

    var body: some View {
        if isLoading {
            ZStack {
                Image("pokemon_splash")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            }
            .edgesIgnoringSafeArea(.all)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    withAnimation {
                        isLoading = false
                    }
                }
            }
        } else {
            MainTabView()
        }
    }
}

struct LaunchScreen_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreen()
    }
}
