import Foundation

protocol AuthServicing {
    func login(email: String, password: String) async throws
}

struct MockAuthService: AuthServicing {
    func login(email: String, password: String) async throws {
        try await Task.sleep(for: .milliseconds(800))

        guard email == "test@example.com", password == "password123" else {
            throw AppError.invalidCredentials
        }
    }
}
