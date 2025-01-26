import Foundation

final class FavoritePokemonListViewModel: ObservableObject {

    @Published
    var pokemonStore: PokemonStore
    let pokemonFavoriteStore: PokemonFavoriteStore
    let pokemonDispatcher: PokemonDispatcher

    init(
        pokemonStore: PokemonStore,
        pokemonFavoriteStore: PokemonFavoriteStore,
        pokemonDispatcher: PokemonDispatcher
    ) {
        self.pokemonStore = pokemonStore
        self.pokemonFavoriteStore = pokemonFavoriteStore
        self.pokemonDispatcher = pokemonDispatcher
    }
}
