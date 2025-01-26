import Foundation

actor PokemonFavoriteStore {
    var favoriteIds: [Int] = []

    private let userDefaults = UserDefaults.standard

    private enum Const {
        static let userDefaultKey = "favorite_pokemon_ids"
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
