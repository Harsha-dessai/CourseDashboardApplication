import Foundation

protocol AuthRepositoryProtocol {
    func login(email: String, password: String) async throws
}

struct AuthRepository: AuthRepositoryProtocol {
    private let service: AuthServicing

    init(service: AuthServicing = MockAuthService()) {
        self.service = service
    }

    func login(email: String, password: String) async throws {
        try await service.login(email: email, password: password)
    }
}
