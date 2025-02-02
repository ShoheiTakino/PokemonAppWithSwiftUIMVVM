import Foundation

struct PokemonDispatcher {

    private let pokemonStore: PokemonStore
    private let pokemonFetcher: PokemonFetcher

    init(
        pokemonStore: PokemonStore,
        pokemonFetcher: PokemonFetcher = PokemonFetcher()
    ) {
        self.pokemonStore = pokemonStore
        self.pokemonFetcher = pokemonFetcher
    }
}

// FetchPokemons
extension PokemonDispatcher {

    func fetchPokemons() async throws {
        // Taskの利用方法問題ないか確認
        try await withThrowingTaskGroup(of: PokemonEntity.self) { pokemonTaskGroup in
            let pokemonIdsRange = 1...151
            for id in pokemonIdsRange {
                pokemonTaskGroup.addTask {
                    let pokemonResponse = try await pokemonFetcher.fetchPokemonDataFrom(id)
                    return try PokemonEntity.init(pokemonResponse)
                }
            }

            for try await pokemon in pokemonTaskGroup {
                pokemonStore.append(pokemon)
            }
        }
    }

    func updateFavorite(_ pokemon: PokemonEntity) {
        pokemonStore.toggleFavorite(pokemon)
    }
}
