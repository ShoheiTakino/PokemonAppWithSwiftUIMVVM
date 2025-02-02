import Foundation

final class PokemonFavoriteStore: ObservableObject {
    var favoriteIds: [Int] = []

    @Published
    var favoritePokemons: [Pokemon] = []

    private let userDefaults = UserDefaults.standard

    private enum Const {
        static let userDefaultKey = "favorite_pokemon_ids"
    }

    @MainActor
    func append(_ favoritePokemon: Pokemon) {
        favoritePokemons.insert(favoritePokemon, at: .zero)
    }

    // お気に入りに追加・削除
    func toggleFavorite(_ pokemon: Pokemon) {
        if let index = favoritePokemons.firstIndex(where: { $0.id == pokemon.id }) {
            if favoritePokemons[index].isFavorite {
                favoritePokemons[index].isFavorite = false
            } else {
                favoritePokemons[index].isFavorite = true
            }
        }
    }

    func appendFavoriteId(_ id: Int) {
        favoriteIds.insert(id, at: .zero)
        let ids = userDefaults.array(forKey: Const.userDefaultKey) as? [Int]
        userDefaults.set(ids, forKey: Const.userDefaultKey)
    }

    func appendAllContents(_ ids: [Int]) {
        favoriteIds.append(contentsOf: ids)
    }

    func removeFavoriteId(_ id: Int) {
        favoriteIds.removeAll(where: { $0 == id })
        guard var ids = userDefaults.array(forKey: Const.userDefaultKey) as? [Int] else { return }
        ids.removeAll(where: { $0 == id })
        userDefaults.set(ids, forKey: Const.userDefaultKey)
    }
}
