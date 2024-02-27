//
//  PokemonDataViewModel.swift
//  PokemonAppWithSwiftUIMVVM
//
//  Created by 滝野翔平 on 2023/04/05.
//

import SwiftUI
import Combine

final class PokemonDataViewModel: ObservableObject {
    @Published var pokemonList: [Pokemon] = []
    @Published var selectedPokemon: Pokemon? = nil
    @Published var isNavigateToDetaileView = false
    let apiClient = PokemonApiClient()
    
    @MainActor
    func fetchPokemonData() async -> [Pokemon]? {
        pokemonList = []
 
        var urlList: [URL] = []
        urlList = createPokemonUrlList()
        do {
            for i in 0..<urlList.count {
                let (data, _) = try await URLSession.shared.data(from: urlList[i])
                let decoder = JSONDecoder()
                let pokemon = try decoder.decode(Pokemon.self, from: data)
                pokemonList.append(pokemon)
            }
            return pokemonList
        } catch {
            
        }
        return nil
    }
    
    /// urlを150体分生成する処理
    private func createPokemonUrlList() -> [URL] {
        var urlList: [URL] = []
        let maxPokemon = 150
        for i in 1...maxPokemon {
            urlList.append(URL(string: "https://pokeapi.co/api/v2/pokemon/\(i)/")!)
        }
        return urlList
    }

    func tappedAtMonstarBallWith(_ pokemon: Pokemon) {
        selectedPokemon = pokemon
        isNavigateToDetaileView = true
    }
}
