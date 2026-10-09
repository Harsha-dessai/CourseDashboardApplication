import Foundation

protocol CourseRepositoryProtocol {
    func fetchCourses() async throws -> [Course]
    func saveCourses(_ courses: [Course]) throws
}

struct CourseRepository: CourseRepositoryProtocol {
    private let api: CourseAPIServicing
    private let storage: LocalCourseStorageProtocol

    init(
        api: CourseAPIServicing = MockCourseAPIService(),
        storage: LocalCourseStorageProtocol = LocalCourseStorage()
    ) {
        self.api = api
        self.storage = storage
    }

    func fetchCourses() async throws -> [Course] {
        do {
            let courses = try await api.fetchCourses()
            try storage.save(courses)
            return courses
        } catch {
            let cached = storage.load()

            guard !cached.isEmpty else {
                throw error
            }

            return cached
        }
    }

    func saveCourses(_ courses: [Course]) throws {
        try storage.save(courses)
    }
}
