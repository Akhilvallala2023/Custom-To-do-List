import Foundation

class TaskViewModel: ObservableObject {
    @Published var tasks: [TaskItem] = []
    @Published var xp: Int = 0
    @Published var userCategories: [String] = []

    // Combines static and user-defined categories
    var allCategories: [String] {
        TaskCategory.allCases.map { $0.displayName } + userCategories
    }

    // MARK: - Add New Task
    func addTask(_ title: String, category: String) {
        let newTask = TaskItem(title: title, isCompleted: false, category: category)
        tasks.append(newTask)
    }

    // MARK: - Delete a Custom Category
    func deleteCategory(_ category: String) {
        // Remove from user-defined categories
        if let index = userCategories.firstIndex(of: category) {
            userCategories.remove(at: index)

            // Also remove all tasks belonging to the deleted category
            tasks.removeAll { $0.category == category }
        }
    }

    // MARK: - Toggle Task Completion and Manage XP
    func toggleComplete(_ task: TaskItem) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            let wasCompleted = tasks[index].isCompleted
            tasks[index].isCompleted.toggle()

            let xpChange = 10  // Same XP for all categories

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
    
    var todoTasks: [TaskItem] {
        tasks.filter { !$0.isCompleted }
    }

    var completedTasks: [TaskItem] {
        tasks.filter { $0.isCompleted }
    }
    
}

