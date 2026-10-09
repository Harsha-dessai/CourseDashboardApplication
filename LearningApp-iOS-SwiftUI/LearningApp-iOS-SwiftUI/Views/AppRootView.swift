import SwiftUI

struct AppRootView: View {
    @State private var loginViewModel = LoginViewModel()

    var body: some View {
        Group {
            if loginViewModel.isLoggedIn {
                DashboardView()
            } else {
                LoginView(viewModel: loginViewModel)
            }
        }
    }
}
