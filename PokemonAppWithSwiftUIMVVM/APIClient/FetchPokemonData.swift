//
//  FetchPokemonData.swift
//  PokemonAppWithSwiftUIMVVM
//
//  Created by 滝野翔平 on 2023/04/05.
//

import Foundation
import Combine

struct FetchPokemonData {
    static let baseURL = "https://jsonplaceholder.typicode.com"
    
    static func fetchPokemonRequest() async -> [PokemonEntity]  {
        var urlList: [URL] = []
        var pokemonList: [PokemonEntity] = []
        for i in 0..<150 {
            let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(i)/")!
            urlList.append(url)
        }
        do {
            for i in 0..<urlList.count {
                let (data, _) = try! await URLSession.shared.data(from: urlList[i])
                let decoder = JSONDecoder()
                let json = try! decoder.decode(PokemonEntity.self, from: data)
                print(#function, json)
                pokemonList.append(json)
            }
            return pokemonList
        }
    }
}
