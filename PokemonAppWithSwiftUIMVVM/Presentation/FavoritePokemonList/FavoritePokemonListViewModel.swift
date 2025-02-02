import Foundation
import Combine
import Observation

@Observable
final class FavoritePokemonListViewModel {

    let pokemonStore: PokemonStore
    let pokemonDispatcher: PokemonDispatcher

    var pokemons: [PokemonEntity] = []
    private(set) var cancellables: Set<AnyCancellable> = Set()

    init(
        pokemonStore: PokemonStore,
        pokemonDispatcher: PokemonDispatcher
    ) {
        self.pokemonStore = pokemonStore
        self.pokemonDispatcher = pokemonDispatcher

        self.pokemonStore.$pokemonList
            .receive(on: DispatchQueue.main)
            .removeDuplicates()
            .map { $0.filter { $0.isFavorite } }
            .sink { [weak self] updatedList in
                guard let self = self else { return }
                self.pokemons = updatedList
            }
            .store(in: &cancellables)
    }

    func onTapFavorite(_ pokemon: PokemonEntity) {
        pokemonDispatcher.updateFavorite(pokemon)
    }
}
