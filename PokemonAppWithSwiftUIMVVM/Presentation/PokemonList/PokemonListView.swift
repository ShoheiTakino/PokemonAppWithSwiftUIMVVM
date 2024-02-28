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
        NavigationStack {
            List(viewModel.pokemonList) { pokemon in
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
            }
            .navigationBarTitle("List")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct PokemonListView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonListView()
    }
}
