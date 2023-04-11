//
//  PokemonListView.swift
//  PokemonAppWithSwiftUIMVVM
//
//  Created by 滝野翔平 on 2023/04/05.
//

import SwiftUI

struct PokemonListView: View {
    
    @StateObject private var viewModel = PokemonDataViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.pokemonList) { pokemon in
                VStack(alignment: .leading, spacing: 10) {
                    Image(pokemon.sprites.frontImage)
                }
            }
            .navigationBarTitle("List")
        }.onAppear {
            Task {
                await viewModel.fetchPokemonList()
            }
        }
    }
}

struct PokemonListView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonListView()
    }
}
