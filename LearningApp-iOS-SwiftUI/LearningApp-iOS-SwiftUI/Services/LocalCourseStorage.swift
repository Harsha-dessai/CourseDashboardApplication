import Foundation

protocol LocalCourseStorageProtocol {
    func save(_ courses: [Course]) throws
    func load() -> [Course]
}

final class LocalCourseStorage: LocalCourseStorageProtocol {
    private let fileURL: URL

    init(fileManager: FileManager = .default) {
        let directory = fileManager.urls(
            for: .applicationSupportDirectory,
            in: .userDomainMask
        )

        try? fileManager.createDirectory(
            at: directory,
            withIntermediateDirectories: true
        )

        self.fileURL = directory.appendingPathComponent("courses-cache.json")
    }

    func save(_ courses: [Course]) throws {
        let data = try JSONEncoder().encode(courses)
        try data.write(to: fileURL, options: [.atomic])
    }

    func load() -> [Course] {
        guard
            let data = try? Data(contentsOf: fileURL),
            let courses = try? JSONDecoder().decode([Course].self, from: data)
        else {
            return []
        }

        return courses
    }
}
