import SwiftUI

struct MainTabView: View {

    var mainTabViewModel: MainTabViewModel

    var body: some View {
        TabView {
            PokemonLazyVGridView(
                viewModel: PokemonLazyVGridViewModel(
                    pokemonStore: mainTabViewModel.pokemonStore,
                    pokemonDispatcher: mainTabViewModel.dispatcher
                )
            )
            .tabItem {
                Image(systemName: "square.grid.2x2")
                Text("LazyGrid")
            }
            PokemonListView(
                viewModel: PokemonListViewModel(
                    pokemonStore: mainTabViewModel.pokemonStore,
                    pokemonDispatcher: mainTabViewModel.dispatcher
                )
            )
            .tabItem {
                Image(systemName: "square.grid.3x3")
                Text("List")
            }
        }
    }
}

//struct MainTabView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainTabView()
//    }
//}
