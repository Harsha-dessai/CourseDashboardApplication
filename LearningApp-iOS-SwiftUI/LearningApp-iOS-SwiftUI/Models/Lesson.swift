import Foundation

struct Lesson: Codable, Identifiable, Hashable {
    let id: Int
    let title: String
    var isCompleted: Bool
}
