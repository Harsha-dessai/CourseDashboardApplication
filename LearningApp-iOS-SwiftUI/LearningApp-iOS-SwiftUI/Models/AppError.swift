import Foundation

enum AppError: LocalizedError {
    case invalidCredentials
    case invalidEmail
    case invalidPassword
    case networkFailure
    case invalidData

    var errorDescription: String? {
        switch self {
        case .invalidCredentials:
            return "Invalid email or password."
        case .invalidEmail:
            return "Please enter a valid email address."
        case .invalidPassword:
            return "Password must contain at least 6 characters."
        case .networkFailure:
            return "The course service is unavailable."
        case .invalidData:
            return "The course data is invalid."
        }
    }
}
