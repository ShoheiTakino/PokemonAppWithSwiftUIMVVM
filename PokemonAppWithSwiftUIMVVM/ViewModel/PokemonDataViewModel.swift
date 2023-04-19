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
    let apiClient = PokemonApiClient()
    
    func fetchPokemonData() async -> [Pokemon]? {
        DispatchQueue.main.async {
            self.pokemonList = []
        }
        var urlList: [URL] = []
        urlList = createPokemonUrlList()
        do {
            for i in 0..<urlList.count {
                let (data, _) = try await URLSession.shared.data(from: urlList[i])
                let decoder = JSONDecoder()
                let pokemon = try decoder.decode(Pokemon.self, from: data)
                // 以下の処理で、警告は修正できるが時々pokemonの画像を処理できない。
//                DispatchQueue.main.async {
//                    self.pokemonList.append(pokemon)
//                }
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
}
