//
//  TaskRowView.swift
//  To do list
//
//  Created by Akhil Vallala on 6/1/25.
//

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

            Text(task.title)
                .strikethrough(task.isCompleted)
                .foregroundColor(task.isCompleted ? .gray : .primary)
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    TaskRowView(
        task: TaskItem(title: "Sample Task", isCompleted: false),
        viewModel: TaskViewModel()
    )
}
