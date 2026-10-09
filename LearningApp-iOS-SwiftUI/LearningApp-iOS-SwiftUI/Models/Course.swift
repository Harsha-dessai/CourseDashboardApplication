import Foundation

struct Course: Codable, Identifiable, Hashable {
    let id: Int
    let title: String
    let instructor: String
    var progress: Int
    var lessons: [Lesson]

    var lessonCount: Int { lessons.count }

    mutating func recalculateProgress() {
        guard !lessons.isEmpty else {
            progress = 0
            return
        }

        progress = Int(
            (Double(lessons.filter(\.isCompleted).count) / Double(lessons.count) * 100).rounded()
        )
    }
}
