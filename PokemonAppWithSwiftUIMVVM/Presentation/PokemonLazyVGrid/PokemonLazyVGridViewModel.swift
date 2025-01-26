import Foundation

final class PokemonLazyVGridViewModel: ObservableObject {

    @Published
    var pokemonStore: PokemonStore
    let pokemonFavoriteStore: PokemonFavoriteStore
    let pokemonDispatcher: PokemonDispatcher

    @Published
    var pokemons: [Pokemon] = []

    init(
        pokemonStore: PokemonStore,
        pokemonFavoriteStore: PokemonFavoriteStore,
        pokemonDispatcher: PokemonDispatcher
    ) {
        self.pokemonStore = pokemonStore
        self.pokemonFavoriteStore = pokemonFavoriteStore
        self.pokemonDispatcher = pokemonDispatcher
    }

    func onAppear() {
        Task {
            do {
                try? await fetchPokemons()
            }
        }
    }

    func fetchPokemons() async throws {
        // Taskの利用方法問題ないか確認
        try await withThrowingTaskGroup(of: Pokemon.self) { pokemonTaskGroup in
            let pokemonIdsRange = 1...150
            for id in pokemonIdsRange {
                pokemonTaskGroup.addTask { [weak self] in
                    guard let self else { throw ErrorType.unknownError }
                    return try await pokemonDispatcher.fetchPokemonsA(id: id)
                }
            }

            for try await pokemon in pokemonTaskGroup {
                await MainActor.run {
                    pokemons.append(pokemon)
                }
            }
            await MainActor.run {
                pokemons.sort(by: { $0.id < $1.id })
            }
        }
    }
}
