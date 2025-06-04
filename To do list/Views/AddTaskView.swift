import SwiftUI

struct AddTaskView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: TaskViewModel
    @State private var taskTitle: String = ""
    @State private var selectedCategory: String = TaskCategory.personal.displayName
    @State private var showingCategoryList = false

    var body: some View {
        NavigationView {
            Form {
                // Task Title Input
                Section(header: Text("Task")) {
                    TextField("Enter task title", text: $taskTitle)
                }

                // Category Selection & Management
                Section {
                    Button(action: { showingCategoryList = true }) {
                        HStack {
                            Text("Category")
                            Spacer()
                            Text(selectedCategory)
                                .foregroundColor(.gray)
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
            .sheet(isPresented: $showingCategoryList) {
                CategoryListView(viewModel: viewModel, selectedCategory: $selectedCategory)
            }
        }
    }
}

#Preview {
    AddTaskView(viewModel: TaskViewModel())
}

