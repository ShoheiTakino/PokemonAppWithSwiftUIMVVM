import Foundation

final class LaunchScreenViewModel: ObservableObject {
    // Store初期化
    let store = PokemonFavoriteStore()
    lazy var dispatcher = PokemonFavoriteDispatcher(pokemonFavoriteStore: store)
}
