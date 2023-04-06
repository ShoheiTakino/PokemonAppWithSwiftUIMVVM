//
//  PokemonDataViewModel.swift
//  PokemonAppWithSwiftUIMVVM
//
//  Created by 滝野翔平 on 2023/04/05.
//

import SwiftUI
import Combine

class PokemonDataViewModel: ObservableObject {
    @Published var posts = [Post]()

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
}
