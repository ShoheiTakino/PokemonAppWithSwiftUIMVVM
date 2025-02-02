import SwiftUI

struct PokemonListView: View {

    var viewModel: PokemonListViewModel

    private enum Const {
        static let columns: [GridItem] = Array(
            repeating: .init(
                .flexible(),
                spacing: 10,
                alignment: .center
            ),
            count: 3
        )
    }

    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                LazyVGrid(columns: Const.columns) {
                    ForEach(viewModel.pokemons) { pokemon in
                        NavigationLink(destination: PokemonDetailView(viewModel: .init(pokemonStore: viewModel.pokemonStore, pokemonDispatcher: viewModel.pokemonDispatcher, pokemon: pokemon))) {
                            VStack(alignment: .center, spacing: 4) {
                                CacheAsyncImage(url: pokemon.imageUrl)
                                    .frame(height: 80)
                                Text(pokemon.name)
                                    .foregroundStyle(.black)
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
            .navigationBarTitle("Grid three columns")
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

struct CacheAsyncImage: View {
    let url: URL

    @State private var image: Image?

    var body: some View {
        if let image = image {
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
        } else {
            AsyncImage(url: url) { phase in
                switch phase {
                case .success(let loadedImage):
                    loadedImage
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                case .failure:
                    ProgressView()
                case .empty:
                    ProgressView()
                @unknown default:
                    ProgressView()
                }
            }
            .onAppear {
                if let cachedImage = ImageCacher.shared[url] {
                    image = cachedImage
                }
            }
        }
    }
}

final class ImageCacher {
    static let shared = ImageCacher()
    private init() {}

    private var cache: [URL: Image] = [:]

    subscript(url: URL) -> Image? {
        get { cache[url] }
        set { cache[url] = newValue }
    }
}
