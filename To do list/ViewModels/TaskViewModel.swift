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
    
    private func calculateXP(for task: TaskItem) -> Int {
        switch task.category {
        case .work: return 15
        case .personal: return 10
        case .study: return 20
        case .health: return 12
        case .other: return 5
        }
    }



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
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            let wasCompleted = tasks[index].isCompleted
            tasks[index].isCompleted.toggle()

            let xpChange = calculateXP(for: tasks[index])

            if tasks[index].isCompleted {
                xp += xpChange  // Gain XP when completed
            } else if wasCompleted {
                xp = max(0, xp - xpChange)  // Remove XP if unchecking
            }
        }
    }



    // MARK: - Delete Task
    func deleteTask(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
    }
}
