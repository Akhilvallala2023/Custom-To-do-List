import SwiftUI

struct AddTaskView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: TaskViewModel
    @State private var taskTitle: String = ""
    @State private var selectedCategory: String = TaskCategory.personal.displayName
    @State private var newCategory: String = ""

    var body: some View {
        NavigationView {
            Form {
                // Task Title Input
                Section(header: Text("Task")) {
                    TextField("Enter task title", text: $taskTitle)
                }

                // Picker for all categories
                Section(header: Text("Category")) {
                    Picker("Category", selection: $selectedCategory) {
                        ForEach(viewModel.allCategories, id: \.self) { category in
                            Text(category).tag(category)
                        }
                    }

                    HStack {
                        TextField("Add new category", text: $newCategory)
                        Button("Add") {
                            let trimmed = newCategory.trimmingCharacters(in: .whitespaces)
                            guard !trimmed.isEmpty, !viewModel.userCategories.contains(trimmed) else { return }
                            viewModel.userCategories.append(trimmed)
                            selectedCategory = trimmed
                            newCategory = ""
                        }
                        .disabled(newCategory.trimmingCharacters(in: .whitespaces).isEmpty)
                    }
                }
            }
            .navigationTitle("New Task")
            .toolbar {
                // Add Task
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add") {
                        let trimmed = taskTitle.trimmingCharacters(in: .whitespaces)
                        if !trimmed.isEmpty {
                            viewModel.addTask(trimmed, category: selectedCategory)
                            dismiss()
                        }
                    }
                }

                // Cancel
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

