//
//  PokemonDataViewModel.swift
//  PokemonAppWithSwiftUIMVVM
//
//  Created by 滝野翔平 on 2023/04/05.
//

import SwiftUI
import Combine

final class PokemonDataViewModel: ObservableObject {
    @Published var posts = [Post]()
    @Published var pokemonList: [Pokemon] = []

    private var cancellables = Set<AnyCancellable>()

    init() {
        fetchPosts()
    }

    func fetchPosts() {
        FetchPokemonData.fetchPosts()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
            } receiveValue: { [weak self] posts in
                self?.posts = posts
            }
            .store(in: &cancellables)
    }
    
    func fetchPokemonList() async {
        let pokemonList = await FetchPokemonData.fetchPokemonRequest()
        self.pokemonList = pokemonList
    }
}
