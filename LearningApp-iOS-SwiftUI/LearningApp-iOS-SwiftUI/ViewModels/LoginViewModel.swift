import Foundation
import Observation

@MainActor
@Observable
final class LoginViewModel {
    var email = ""
    var password = ""
    var isLoading = false
    var errorMessage: String?
    var isLoggedIn = false

    private let repository: AuthRepositoryProtocol

    init(repository: AuthRepositoryProtocol = AuthRepository()) {
        self.repository = repository
    }

    func login() async {
        errorMessage = nil

        guard email.contains("@"), email.contains(".") else {
            errorMessage = AppError.invalidEmail.localizedDescription
            return
        }

        guard password.count >= 6 else {
            errorMessage = AppError.invalidPassword.localizedDescription
            return
        }

        isLoading = true
        defer { isLoading = false }

        do {
            try await repository.login(email: email, password: password)
            isLoggedIn = true
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
