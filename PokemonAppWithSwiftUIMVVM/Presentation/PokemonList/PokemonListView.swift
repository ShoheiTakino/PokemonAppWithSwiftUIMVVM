//
//  PokemonListView.swift
//  PokemonAppWithSwiftUIMVVM
//
//  Created by 滝野翔平 on 2023/04/05.
//

import SwiftUI

struct PokemonListView: View {
    @StateObject var viewModel: PokemonListViewModel

    var body: some View {
        NavigationStack {
            List(viewModel.pokemonStore.pokemonList) { pokemon in
                HStack {
                    AsyncImage(url: URL(string: pokemon.sprites.frontImage)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 40)
                    } placeholder: {
                        ProgressView()
                    }
                    Text(pokemon.name)
                    NavigationLink(destination: PokemonDetailView(pokemon: pokemon)) {
                        
                    }
                }
                .onAppear {
                    print("ああああ", pokemon.id)
                }
            }
            .navigationBarTitle("List")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) { // 右側に配置
                    NavigationLink(destination: FavoritePokemonListView(viewModel: .init(pokemonStore: viewModel.pokemonStore, pokemonFavoriteStore: viewModel.pokemonFavoriteStore, pokemonDispatcher: viewModel.pokemonDispatcher))) {
                        Image(systemName: "plus") // ボタンのアイコン（システムアイコンを使用）
                            .foregroundColor(.blue)
                    }
                }
            }
        }
    }
}

//struct PokemonListView_Previews: PreviewProvider {
//    static var previews: some View {
//        PokemonListView()
//    }
//}
