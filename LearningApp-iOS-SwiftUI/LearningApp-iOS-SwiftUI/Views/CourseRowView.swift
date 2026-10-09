import SwiftUI

struct CourseRowView: View {
    let course: Course

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(course.title)
                        .font(.headline)

                    Text(course.instructor)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }

                Spacer()

                Text("\(course.progress)%")
                    .font(.headline)
            }

            ProgressView(value: Double(course.progress), total: 100)

            HStack {
                Label(
                    "\(course.lessonCount) lessons",
                    systemImage: "play.rectangle"
                )
                .font(.caption)
                .foregroundStyle(.secondary)

                Spacer()

                Text("Continue")
                    .font(.caption.bold())
                    .foregroundStyle(.tint)
            }
        }
        .padding(.vertical, 8)
    }
}
