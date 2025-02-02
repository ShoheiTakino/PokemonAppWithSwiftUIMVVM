import SwiftUI

@main
struct PokemonAppWithSwiftUIMVVMApp: App {
    var body: some Scene {
        WindowGroup {
            LaunchScreenView(viewModel: LaunchScreenViewModel())
        }
    }
}
