import SwiftUI

struct DashboardView: View {
    @State private var viewModel = DashboardViewModel()

    var body: some View {
        NavigationStack {
            Group {
                switch viewModel.state {
                case .loading:
                    ProgressView("Loading courses…")

                case .success:
                    List(viewModel.courses) { course in
                        NavigationLink {
                            CourseDetailView(
                                course: course,
                                repository: CourseRepository()
                            ) { updatedCourse in
                                viewModel.update(course: updatedCourse)
                            }
                        } label: {
                            CourseRowView(course: course)
                        }
                    }
                    .listStyle(.plain)

                case .empty:
                    ContentUnavailableView(
                        "No Courses",
                        systemImage: "books.vertical",
                        description: Text("There are no courses available.")
                    )

                case .failure(let message):
                    VStack(spacing: 16) {
                        ContentUnavailableView(
                            "Couldn’t Load Courses",
                            systemImage: "wifi.exclamationmark",
                            description: Text(message)
                        )

                        Button("Try Again") {
                            Task { await viewModel.loadCourses() }
                        }
                        .buttonStyle(.borderedProminent)
                    }
                }
            }
            .navigationTitle("Courses")
            .task {
                await viewModel.loadCourses()
            }
        }
    }
}
