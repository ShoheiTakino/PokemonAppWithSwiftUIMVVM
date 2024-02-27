//
//  PokemonDetailView.swift
//  PokemonAppWithSwiftUIMVVM
//
//  Created by 滝野翔平 on 2023/04/05.
//

import SwiftUI

struct PokemonDetailView: View {
    var pokemon: PokemonEntity
    
    var body: some View {
        Text("No. \(pokemon.id)")
            .font(.title)
            .fontWeight(.semibold)
        AsyncImage(url: URL(string: pokemon.sprites.frontImage)) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 200)
        } placeholder: {
            ProgressView()
        }
        Text(pokemon.name)
            .font(.body)
            .fontWeight(.bold)
        Text("\(pokemon.types[0].type.name)タイプ")
            .font(.body)
            .fontWeight(.bold)
    }
}
