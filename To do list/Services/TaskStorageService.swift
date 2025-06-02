//
//  TaskStorageService.swift
//  To do list
//
//  Created by Akhil Vallala on 6/1/25.
//

import Foundation

class TaskStorageService {
    private let storageKey = "SavedTasks"

    // Save tasks to UserDefaults
    func saveTasks(_ tasks: [TaskItem]) {
        if let encoded = try? JSONEncoder().encode(tasks) {
            UserDefaults.standard.set(encoded, forKey: storageKey)
        }
    }

    // Load tasks from UserDefaults
    func loadTasks() -> [TaskItem] {
        guard let savedData = UserDefaults.standard.data(forKey: storageKey),
              let decoded = try? JSONDecoder().decode([TaskItem].self, from: savedData) else {
            return []
        }
        return decoded
    }
}
