import Foundation

protocol CourseAPIServicing {
    func fetchCourses() async throws -> [Course]
}

struct MockCourseAPIService: CourseAPIServicing {
    let shouldFail: Bool

    init(shouldFail: Bool = false) {
        self.shouldFail = shouldFail
    }

    func fetchCourses() async throws -> [Course] {
        try await Task.sleep(for: .milliseconds(900))

        if shouldFail {
            throw AppError.networkFailure
        }

        guard let url = Bundle.main.url(forResource: "courses", withExtension: "json") else {
            throw AppError.invalidData
        }

        do {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode([Course].self)
        } catch {
            
        }
    }
}
