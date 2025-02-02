import SwiftUI

struct PokemonDetailView: View {

    var viewModel: PokemonDetailViewModel

    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                Text("No. \(viewModel.pokemon.id)")
                    .font(.title)
                    .fontWeight(.semibold)
                CacheAsyncImage(url: viewModel.pokemon.imageUrl)
                        .frame(height: 200)
                Text(viewModel.pokemon.name)
                    .font(.body)
                    .fontWeight(.bold)
                Text("\(viewModel.pokemon.types.first ?? "謎")タイプ")
                    .font(.body)
                    .fontWeight(.bold)
            }
        }
        .navigationBarTitle("ポケモン詳細")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                FavoriteButtonView(
                    isFavorite: viewModel.pokemon.isFavorite,
                    onTapFavoriteButton: {
                        viewModel.onTapFavorite()
                    }
                )
            }
        }
        .toolbar(.hidden, for: .tabBar)
    }
}
