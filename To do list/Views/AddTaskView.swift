import SwiftUI

struct AddTaskView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: TaskViewModel
    @State private var taskTitle: String = ""
    @State private var selectedCategory: TaskCategory = .personal

    var body: some View {
        NavigationView {
            Form {
                // Task Title Input
                TextField("Enter task title", text: $taskTitle)

                // Category Picker
                Picker("Category", selection: $selectedCategory) {
                    ForEach(TaskCategory.allCases) { category in
                        Text(category.displayName).tag(category)
                    }
                }
            }
            .navigationTitle("New Task")
            .toolbar {
                // Add Button
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add") {
                        if !taskTitle.trimmingCharacters(in: .whitespaces).isEmpty {
                            viewModel.addTask(taskTitle, category: selectedCategory)
                            dismiss()
                        }
                    }
                }

                // Cancel Button
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    AddTaskView(viewModel: TaskViewModel())
}

