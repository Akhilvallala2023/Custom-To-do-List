import SwiftUI

struct TaskRowView: View {
    var task: TaskItem
    var viewModel: TaskViewModel
    var isTiming: Bool = false
    var elapsedTime: Int? = nil

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

                // ✅ LIVE TIMER WHILE WORKING
                if isTiming, let elapsed = elapsedTime {
                    let minutes = elapsed / 60
                    let seconds = elapsed % 60
                    Text(String(format: "⏱ %02d:%02d", minutes, seconds))
                        .font(.caption2)
                        .foregroundColor(.blue)
                }

                // ✅ DISPLAY AFTER COMPLETION
                if task.isCompleted, let spent = task.timeSpent {
                    let minutes = Int(spent) / 60
                    let seconds = Int(spent) % 60
                    Text(String(format: "⏱ Completed in %02d:%02d", minutes, seconds))
                        .font(.caption2)
                        .foregroundColor(.green)
                }
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    TaskRowView(
        task: TaskItem(title: "Sample Task", isCompleted: false, category: "Work"),
        viewModel: TaskViewModel(),
        isTiming: true,
        elapsedTime: 125
    )
}
