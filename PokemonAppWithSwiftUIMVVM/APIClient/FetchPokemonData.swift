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

    static func fetchPosts() -> AnyPublisher<[Post], Error> {
        let url = URL(string: "\(Constants.jsonUrl)/posts")!

        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [Post].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    static func fetchPokemonRequest() async -> [Pokemon]  {
        var urlList: [URL] = []
        var pokemonList: [Pokemon] = []
        for i in 0..<150 {
            let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(i)/")!
            urlList.append(url)
        }
        do {
            for i in 0..<urlList.count {
                let (data, _) = try! await URLSession.shared.data(from: urlList[i])
                let decoder = JSONDecoder()
                let json = try! decoder.decode(Pokemon.self, from: data)
                print(#function, json)
                pokemonList.append(json)
            }
            return pokemonList
        }
    }
}
