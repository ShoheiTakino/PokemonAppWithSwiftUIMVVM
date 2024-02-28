//
//  PokemonApiClient.swift
//  PokemonAppWithSwiftUIMVVM
//
//  Created by 滝野翔平 on 2023/04/19.
//

import Foundation

final class PokemonApiClient: ObservableObject {
    @Published var pokemonList: [PokemonEntity] = []

    func fetchPokemonData() async -> [PokemonEntity]? {
        pokemonList = []
        var urlList: [URL] = []
        urlList = createPokemonUrlList()
        do {
            for i in 0..<urlList.count {
                let (data, _) = try await URLSession.shared.data(from: urlList[i])
                let decoder = JSONDecoder()
                let pokemon = try decoder.decode(PokemonEntity.self, from: data)
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
