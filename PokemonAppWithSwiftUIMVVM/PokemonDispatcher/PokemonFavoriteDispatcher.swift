import Foundation

struct PokemonDispatcher {

    let pokemonFavoriteStore: PokemonFavoriteStore
    let pokemonStore: PokemonStore

    init(
        pokemonStore: PokemonStore,
        pokemonFavoriteStore: PokemonFavoriteStore
    ) {
        self.pokemonStore = pokemonStore
        self.pokemonFavoriteStore = pokemonFavoriteStore
    }
}

// FetchPokemons
extension PokemonDispatcher {

    func fetchPokemons() async throws {
        let pokemonFetcher = PokemonFetcher()

        // Taskの利用方法問題ないか確認
        try await withThrowingTaskGroup(of: Pokemon.self) { pokemonTaskGroup in
            let pokemonIdsRange = 1...150
            for id in pokemonIdsRange {
                pokemonTaskGroup.addTask {
                    try await pokemonFetcher.fetchPokemonDataFrom(id)
                }
            }

            for try await pokemon in pokemonTaskGroup {
                await MainActor.run {
                    pokemonStore.appendPokemon(pokemon)
                }
            }
        }
    }

    func fetchPokemonsA(id: Int) async throws -> Pokemon {
        let pokemonFetcher = PokemonFetcher()
        return try await pokemonFetcher.fetchPokemonDataFrom(id)
    }
}

enum ErrorType: Error {
    case unknownError
}
