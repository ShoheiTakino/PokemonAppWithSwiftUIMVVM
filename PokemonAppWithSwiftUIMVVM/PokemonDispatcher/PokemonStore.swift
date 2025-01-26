import Foundation

//@MainActor
final class PokemonStore: ObservableObject {
    @Published var pokemonList: [Pokemon] = []

    func appendPokemon(_ pokemon: Pokemon) {
        pokemonList.append(pokemon)
        pokemonList.sort(by: { $0.id < $1.id })
    }
}
