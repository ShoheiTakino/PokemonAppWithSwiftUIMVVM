import Foundation
import Combine
import Observation

@Observable
final class PokemonLazyVGridViewModel {

    let pokemonStore: PokemonStore
    let pokemonDispatcher: PokemonDispatcher

    var pokemons: [PokemonEntity] = []
    private var cancellables: Set<AnyCancellable> = Set()

    init(
        pokemonStore: PokemonStore,
        pokemonDispatcher: PokemonDispatcher
    ) {
        self.pokemonStore = pokemonStore
        self.pokemonDispatcher = pokemonDispatcher

        // pokemonStore の変更を監視
        self.pokemonStore.$pokemonList
            .receive(on: DispatchQueue.main)
            .removeDuplicates()
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
