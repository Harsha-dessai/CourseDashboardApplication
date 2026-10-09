import Foundation
import Observation

@MainActor
@Observable
final class CourseDetailViewModel {
    private(set) var course: Course
    private let repository: CourseRepositoryProtocol
    private let onCourseUpdated: (Course) -> Void

    init(
        course: Course,
        repository: CourseRepositoryProtocol,
        onCourseUpdated: @escaping (Course) -> Void
    ) {
        self.course = course
        self.repository = repository
        self.onCourseUpdated = onCourseUpdated
    }

    func markCompleted(lessonID: Int) {
        guard let index = course.lessons.firstIndex(where: { $0.id == lessonID }) else {
            return
        }

        guard !course.lessons[index].isCompleted else {
            return
        }

        course.lessons[index].isCompleted = true
        course.recalculateProgress()

        try? repository.saveCourses([course])
        onCourseUpdated(course)
    }
}
