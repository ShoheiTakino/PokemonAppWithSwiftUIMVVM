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
    
    static func fetchPokemonRequest() {
        
    }
}
