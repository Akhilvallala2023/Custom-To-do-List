import SwiftUI

struct TaskRowView: View {
    var task: TaskItem
    var viewModel: TaskViewModel

    var body: some View {
        HStack {
            Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                .foregroundColor(task.isCompleted ? .green : .gray)
                .onTapGesture {
                    viewModel.toggleComplete(task)
                }

            VStack(alignment: .leading, spacing: 2) {
                Text(task.title)
                    .strikethrough(task.isCompleted)
                    .foregroundColor(task.isCompleted ? .gray : .primary)

                Text(task.category.capitalized)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    TaskRowView(
        task: TaskItem(title: "Sample Task", isCompleted: false, category: "Work"),
        viewModel: TaskViewModel()
    )
}

