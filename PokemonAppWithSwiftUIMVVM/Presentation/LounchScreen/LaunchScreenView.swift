import SwiftUI

struct LaunchScreenView: View {
    var viewModel: LaunchScreenViewModel
    @State private var isLoading = true

    var body: some View {
        if isLoading {
            ZStack {
                Image("pokemon_splash")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            }
            .ignoresSafeArea()
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    withAnimation {
                        isLoading = false
                    }
                }
            }
        } else {
            MainTabView(mainTabViewModel: viewModel.mainTabViewModel)
        }
    }
}
