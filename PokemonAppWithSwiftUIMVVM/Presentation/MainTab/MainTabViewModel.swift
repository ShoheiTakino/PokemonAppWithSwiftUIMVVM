import SwiftUI

@MainActor
final class MainTabViewModel: ObservableObject {
    var favoritePokemonStore = PokemonFavoriteStore()
    var pokemonStore = PokemonStore()
    lazy var dispatcher = PokemonDispatcher(
        pokemonStore: pokemonStore,
        pokemonFavoriteStore: favoritePokemonStore
    )

    var task: Task<Void, Never>?

    init() {
        task = Task { [weak self] in
            do {
//                try? await self?.dispatcher.fetchPokemons()
            }
        }
    }

    deinit {
        self.task?.cancel()
    }
}
