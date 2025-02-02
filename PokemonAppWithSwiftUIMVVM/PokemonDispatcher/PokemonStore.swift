import Foundation

final class PokemonStore: ObservableObject {
    @Published var pokemonList: [PokemonEntity] = []

    func append(_ pokemon: PokemonEntity) {
        pokemonList.append(pokemon)
        pokemonList.sort(by: { $0.id < $1.id })
    }

    // お気に入りに追加・削除
    func toggleFavorite(_ pokemon: PokemonEntity) {
        if let index = pokemonList.firstIndex(where: { $0.id == pokemon.id }) {
            if pokemonList[index].isFavorite {
                pokemonList[index].isFavorite = false
            } else {
                pokemonList[index].isFavorite = true
            }
        }
    }
}
