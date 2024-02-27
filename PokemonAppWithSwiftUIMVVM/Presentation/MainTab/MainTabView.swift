//
//  MainTabView.swift
//  PokemonAppWithSwiftUIMVVM
//
//  Created by 滝野翔平 on 2023/04/05.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            PokemonLazyVGridView()
                .tabItem {
                    Image(systemName: "square.grid.2x2")
                    Text("LazyGrid")
                }
            PokemonListView()
                .tabItem {
                    Image(systemName: "rectangle.grid.1x2")
                    Text("List")
                }
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
