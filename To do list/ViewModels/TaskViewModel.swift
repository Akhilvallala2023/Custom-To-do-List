//
//  TaskViewModel.swift
//  To do list
//
//  Created by Akhil Vallala on 6/1/25.
//

import Foundation


class TaskViewModel: ObservableObject {
    @Published var tasks: [TaskItem] = []
    @Published var xp: Int = 0

    var level: Int {
        var total = 0
        var lvl = 0
        while xp >= total + (lvl + 1) * 50 {
            lvl += 1
            total += lvl * 50
        }
        return lvl
    }

    var xpAtCurrentLevelStart: Int {
        var total = 0
        var lvl = 0
        while xp >= total + (lvl + 1) * 50 {
            lvl += 1
            total += lvl * 50
        }
        return total
    }

    var xpForNextLevel: Int {
        let nextLevel = level + 1
        var total = 0
        for i in 1...nextLevel {
            total += i * 50
        }
        return total
    }



    // MARK: - Add New Task
    func addTask(_ title: String, category: TaskCategory) {
        let newTask = TaskItem(title: title, isCompleted: false, category: category)
        tasks.append(newTask)
    }


    // MARK: - Toggle Task Completion
    func toggleComplete(_ task: TaskItem) {
        guard let index = tasks.firstIndex(where: { $0.id == task.id }) else { return }
        tasks[index].isCompleted.toggle()

        if tasks[index].isCompleted {
            let daysDiff = Calendar.current.dateComponents([.day], from: tasks[index].createdAt, to: Date()).day ?? 0
            let awardedXP = max(10 - daysDiff, 1)
            xp += awardedXP
        }
    }

    // MARK: - Delete Task
    func deleteTask(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
    }
}
