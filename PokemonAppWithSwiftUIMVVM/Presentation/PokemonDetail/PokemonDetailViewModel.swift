import Foundation
import Combine
import Observation

@Observable
final class PokemonDetailViewModel {
    let pokemonStore: PokemonStore
    let pokemonDispatcher: PokemonDispatcher

    private var cancellables: Set<AnyCancellable> = Set()
    var pokemon: PokemonEntity

    init(
        pokemonStore: PokemonStore,
        pokemonDispatcher: PokemonDispatcher,
        pokemon: PokemonEntity
    ) {
        self.pokemonStore = pokemonStore
        self.pokemonDispatcher = pokemonDispatcher
        self.pokemon = pokemon

        self.pokemonStore.$pokemonList
            .receive(on: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] updatedList in
                guard let self = self else { return }
                if let updatedPokemon = updatedList.first(where: { $0.id == self.pokemon.id }) {
                    self.pokemon.isFavorite = updatedPokemon.isFavorite
                }
            }
            .store(in: &cancellables)
    }


    func onTapFavorite() {
        pokemonDispatcher.updateFavorite(pokemon)
    }
}
