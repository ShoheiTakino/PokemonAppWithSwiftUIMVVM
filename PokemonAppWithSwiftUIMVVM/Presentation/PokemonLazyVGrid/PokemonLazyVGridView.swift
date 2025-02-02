import SwiftUI

struct PokemonLazyVGridView: View {
    var viewModel: PokemonLazyVGridViewModel

    private enum Const {
        static let columns: [GridItem] = Array(
            repeating: .init(
                .flexible(),
                spacing: 10,
                alignment: .center
            ),
            count: 2
        )
    }
    let screenWidth = UIScreen.main.bounds.width

    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                LazyVGrid(columns: Const.columns) {
                    ForEach(viewModel.pokemons) { pokemon in
                        NavigationLink(destination: PokemonDetailView(viewModel: .init(pokemonStore: viewModel.pokemonStore, pokemonDispatcher: viewModel.pokemonDispatcher, pokemon: pokemon))) {
                            CacheAsyncImage(url: pokemon.imageUrl)
                                .frame(height: screenWidth / 3)
                                .padding()
                                .frame(width: screenWidth / 2.1, height: 200)
                                .background {
                                    ZStack {
                                        Circle()
                                            .fill(Color.red)
                                            .frame(height: screenWidth / 2)
                                        Rectangle()
                                            .fill(Color.white)
                                            .frame(width: screenWidth / 2.1)
                                            .offset(y: screenWidth / 4)
                                    }
                                }
                                .clipShape(Circle())
                                .overlay {
                                    Circle()
                                        .stroke(Color.black, lineWidth: 1)
                                }
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
            .navigationBarTitle("一覧(GridLayout)")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: FavoritePokemonListView(viewModel: .init(pokemonStore: viewModel.pokemonStore, pokemonDispatcher: viewModel.pokemonDispatcher))) {
                        Image(systemName: "rectangle.grid.1x2")
                            .foregroundColor(.primary)
                    }
                }
            }
        }
    }
}
