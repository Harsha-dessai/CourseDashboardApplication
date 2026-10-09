import Foundation
import Observation

enum DashboardState: Equatable {
    case loading
    case success
    case empty
    case failure(String)
}

@MainActor
@Observable
final class DashboardViewModel {
    var courses: [Course] = []
    var state: DashboardState = .loading

    private let repository: CourseRepositoryProtocol

    init(repository: CourseRepositoryProtocol = CourseRepository()) {
        self.repository = repository
    }

    func loadCourses() async {
        state = .loading

        do {
            courses = try await repository.fetchCourses()
            state = courses.isEmpty ? .empty : .success
        } catch {
            state = .failure(error.localizedDescription)
        }
    }

    func update(course: Course) {
        guard let index = courses.firstIndex(where: { $0.id == course.id }) else {
            return
        }

        courses[index] = course
    }
}
