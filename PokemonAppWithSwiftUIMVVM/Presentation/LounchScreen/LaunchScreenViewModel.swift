import Foundation

final class LaunchScreenViewModel {
    let mainTabViewModel: MainTabViewModel
    init(
        mainTabViewModel: MainTabViewModel = MainTabViewModel()
    ) {
        self.mainTabViewModel = mainTabViewModel
    }
}
