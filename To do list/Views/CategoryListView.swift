import SwiftUI

struct CategoryListView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: TaskViewModel
    @Binding var selectedCategory: String
    @State private var newCategory: String = ""

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Categories")) {
                    ForEach(viewModel.allCategories, id: \.self) { category in
                        HStack {
                            Text(category)
                            Spacer()
                            if viewModel.userCategories.contains(category) {
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
                        .contentShape(Rectangle())
                        .onTapGesture {
                            selectedCategory = category
                            dismiss()
                        }
                    }
                }

                Section(header: Text("Add New Category")) {
                    HStack {
                        TextField("New category", text: $newCategory)
                        Button("Add") {
                            let trimmed = newCategory.trimmingCharacters(in: .whitespaces)
                            guard !trimmed.isEmpty,
                                  !viewModel.allCategories.contains(trimmed) else { return }
                            viewModel.userCategories.append(trimmed)
                            selectedCategory = trimmed
                            newCategory = ""
                        }
                        .disabled(newCategory.trimmingCharacters(in: .whitespaces).isEmpty)
                    }
                }
            }
            .navigationTitle("Select Category")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Done") { dismiss() }
                }
            }
        }
    }
}

#Preview {
    CategoryListView(viewModel: TaskViewModel(), selectedCategory: .constant(TaskCategory.personal.displayName))
}
