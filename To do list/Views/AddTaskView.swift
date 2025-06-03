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

                // Category Selection & Management
                Section(header: Text("Category")) {
                    // Picker for predefined + user categories
                    Picker("Category", selection: $selectedCategory) {
                        ForEach(viewModel.allCategories, id: \.self) { category in
                            Text(category).tag(category)
                        }
                    }

                    // Add New Category
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

                    // 🔥 List of user-defined categories with delete option
                    if !viewModel.userCategories.isEmpty {
                        ForEach(viewModel.userCategories, id: \.self) { category in
                            HStack {
                                Text(category)
                                Spacer()
                                Button(role: .destructive) {
                                    viewModel.deleteCategory(category)
                                    if selectedCategory == category {
                                        selectedCategory = TaskCategory.personal.displayName
                                    }
                                } label: {
                                    Image(systemName: "trash")
                                }
                                .buttonStyle(BorderlessButtonStyle())
                            }
                        }
                    }
                }
            }
            .navigationTitle("New Task")
            .toolbar {
                // Add Button
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add") {
                        let trimmed = taskTitle.trimmingCharacters(in: .whitespaces)
                        if !trimmed.isEmpty {
                            viewModel.addTask(trimmed, category: selectedCategory)
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

