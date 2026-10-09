import SwiftUI

struct CourseDetailView: View {
    @State private var viewModel: CourseDetailViewModel

    init(
        course: Course,
        repository: CourseRepositoryProtocol,
        onCourseUpdated: @escaping (Course) -> Void
    ) {
        _viewModel = State(
            initialValue: CourseDetailViewModel(
                course: course,
                repository: repository,
                onCourseUpdated: onCourseUpdated
            )
        )
    }

    var body: some View {
        List {
            Section {
                VStack(alignment: .leading, spacing: 10) {
                    Text(viewModel.course.title)
                        .font(.title2.bold())

                    Text(viewModel.course.instructor)
                        .foregroundStyle(.secondary)

                    ProgressView(
                        value: Double(viewModel.course.progress),
                        total: 100
                    )

                    Text("\(viewModel.course.progress)% complete")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                .padding(.vertical, 8)
            }

            Section("Lessons") {
                ForEach(viewModel.course.lessons) { lesson in
                    Button {
                        viewModel.markCompleted(lessonID: lesson.id)
                    } label: {
                        HStack(spacing: 12) {
                            Image(
                                systemName: lesson.isCompleted
                                    ? "checkmark.circle.fill"
                                    : "circle"
                            )
                            .foregroundStyle(
                                lesson.isCompleted ? .green : .secondary
                            )

                            Text(lesson.title)
                                .foregroundStyle(.primary)

                            Spacer()

                            Text(
                                lesson.isCompleted
                                    ? "Completed"
                                    : "Pending"
                            )
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        }
                    }
                    .buttonStyle(.plain)
                }
            }
        }
        .navigationTitle("Course Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}
