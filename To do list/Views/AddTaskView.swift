//
//  AddTaskView.swift
//  To do list
//
//  Created by Akhil Vallala on 6/1/25.
//

import SwiftUI

struct AddTaskView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: TaskViewModel
    @State private var taskTitle: String = ""

    var body: some View {
        NavigationView {
            Form {
                TextField("Enter task title", text: $taskTitle)
            }
            .navigationTitle("New Task")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add") {
                        if !taskTitle.trimmingCharacters(in: .whitespaces).isEmpty {
                            viewModel.addTask(taskTitle)
                            dismiss()
                        }
                    }
                }

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
