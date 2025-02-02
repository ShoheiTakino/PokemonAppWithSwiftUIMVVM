import Foundation

struct PokemonFetcher {
    func fetchPokemonDataFrom(_ pokemonId: Int) async throws -> PokemonResponse {

        guard let url = URL(string: "\(Const.pokeAPIUrl)\(pokemonId)/") else {
            throw URLGenerateError.invalidURL
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        let pokemon = try JSONDecoder().decode(PokemonResponse.self, from: data)
        return pokemon
    }

    private enum URLGenerateError: Error {
        case invalidURL
    }
}
