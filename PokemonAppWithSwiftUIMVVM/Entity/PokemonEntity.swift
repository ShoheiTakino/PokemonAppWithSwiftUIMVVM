import Foundation

struct PokemonEntity: Sendable, Identifiable, Equatable {
    let id: Int
    let name: String
    let imageUrl: URL
    let types: [String]
    var isFavorite: Bool

    init(_ pokemon: PokemonResponse) throws {
        self.id = pokemon.id
        self.name = pokemon.name
        self.imageUrl = if let imageUrl = URL(string: pokemon.sprites.frontImage) {
            imageUrl
        } else {
            throw ImageConvertError.invalidURL
        }
        self.types = pokemon.types.map({ $0.type.name })
        self.isFavorite = false // 初期はお気に入り状態ではない
    }

    private enum ImageConvertError: Error {
        case invalidURL
    }
}
