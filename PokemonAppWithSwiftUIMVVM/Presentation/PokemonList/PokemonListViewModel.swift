import Foundation

final class PokemonListViewModel: ObservableObject {

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

extension PokemonListViewModel {
    @MainActor
    func onAppear() {
        print("ああああ", pokemonStore.pokemonList)
    }
}
