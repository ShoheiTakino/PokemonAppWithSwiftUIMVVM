import SwiftUI

struct FavoritePokemonListView: View {
    
    var viewModel: FavoritePokemonListViewModel

    private enum Const {
        static let columns: [GridItem] = Array(
            repeating: .init(
                .flexible(),
                spacing: 10,
                alignment: .center
            ),
            count: 1
        )
    }

    var body: some View {
        ScrollView(.vertical) {
            LazyVGrid(columns: Const.columns) {
                ForEach(viewModel.pokemons) { pokemon in
                    HStack {
                        NavigationLink(destination: PokemonDetailView(viewModel: .init(pokemonStore: viewModel.pokemonStore, pokemonDispatcher: viewModel.pokemonDispatcher, pokemon: pokemon))) {
                            CacheAsyncImage(url: pokemon.imageUrl)
                                .frame(width: 100, height: 100)
                        }
                        Text(pokemon.name)
                    }
                    .overlay(alignment: .topTrailing) {
                        FavoriteButtonView(
                            isFavorite: pokemon.isFavorite,
                            onTapFavoriteButton: {
                                viewModel.onTapFavorite(pokemon)
                            }
                        )
                    }
                }
            }
        }
        .toolbar(.hidden, for: .tabBar)
    }
}
