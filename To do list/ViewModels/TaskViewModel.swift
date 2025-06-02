//
//  TaskViewModel.swift
//  To do list
//
//  Created by Akhil Vallala on 6/1/25.
//

import Foundation

class TaskViewModel: ObservableObject {
    @Published var tasks: [TaskItem] = []

    // MARK: - Add New Task
    func addTask(_ title: String) {
        let newTask = TaskItem(title: title, isCompleted: false)
        tasks.append(newTask)
    }

    // MARK: - Toggle Task Completion
    func toggleComplete(_ task: TaskItem) {
        guard let index = tasks.firstIndex(where: { $0.id == task.id }) else { return }
        tasks[index].isCompleted.toggle()
    }

    // MARK: - Delete Task
    func deleteTask(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
    }
}
