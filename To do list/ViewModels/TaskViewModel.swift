import Foundation

class TaskViewModel: ObservableObject {
    @Published var tasks: [TaskItem] = []
    @Published var xp: Int = 0
    @Published var userCategories: [String] = []

    var allCategories: [String] {
        TaskCategory.allCases.map { $0.displayName } + userCategories
    }

    // MARK: - Add New Task
    func addTask(_ title: String, category: String) {
        let newTask = TaskItem(title: title, isCompleted: false, category: category)
        tasks.append(newTask)
    }

    // MARK: - Toggle Task Completion
    func toggleComplete(_ task: TaskItem) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            let wasCompleted = tasks[index].isCompleted
            tasks[index].isCompleted.toggle()

            let xpChange = 10  // ✅ Fixed XP for every category

            if tasks[index].isCompleted {
                xp += xpChange
            } else if wasCompleted {
                xp = max(0, xp - xpChange)
            }
        }
    }

    // MARK: - Delete Task
    func deleteTask(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
    }

    // MARK: - Level System
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
}

