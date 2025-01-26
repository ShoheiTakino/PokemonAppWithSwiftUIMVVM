import Foundation

struct PokemonFetcher {
    func fetchPokemonDataFrom(_ pokemonId: Int) async throws -> Pokemon {
        let url: URL = {
            URL(string: "\(Const.pokeAPIUrl)\(pokemonId)/")!
        }()

        let (data, _) = try await URLSession.shared.data(from: url)
        let pokemon = try JSONDecoder().decode(Pokemon.self, from: data)
        return pokemon
    }
}
