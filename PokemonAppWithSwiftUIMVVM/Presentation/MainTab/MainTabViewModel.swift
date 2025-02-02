import SwiftUI

final class MainTabViewModel {
    let pokemonStore: PokemonStore
    lazy var dispatcher = PokemonDispatcher(
        pokemonStore: pokemonStore
    )

    var task: Task<Void, Never>?

    init(
        pokemonStore: PokemonStore = PokemonStore(),
        task: Task<Void, Never>? = nil
    ) {
        self.pokemonStore = pokemonStore
        self.task = Task { [weak self] in
            do {
                try await self?.dispatcher.fetchPokemons()
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    deinit {
        self.task?.cancel()
    }
}
