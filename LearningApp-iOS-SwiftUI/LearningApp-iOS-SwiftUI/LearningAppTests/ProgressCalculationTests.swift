import XCTest
@testable import LearningApp

final class ProgressCalculationTests: XCTestCase {
    func testProgressRecalculatesAfterCompletingLesson() {
        var course = Course(
            id: 1,
            title: "Test",
            instructor: "Instructor",
            progress: 25,
            lessons: [
                Lesson(id: 1, title: "One", isCompleted: true),
                Lesson(id: 2, title: "Two", isCompleted: false),
                Lesson(id: 3, title: "Three", isCompleted: false),
                Lesson(id: 4, title: "Four", isCompleted: false)
            ]
        )

        course.lessons[1].isCompleted = true
        course.recalculateProgress()

        XCTAssertEqual(course.progress, 50)
    }
}
