//
//  TaskItem.swift
//  To do list
//
//  Created by Akhil Vallala on 6/1/25.
//

import Foundation

enum TaskCategory: String, Codable, CaseIterable, Identifiable {
    case personal
    case work
    case study
    case health
    case other

    var id: String { self.rawValue }

    var displayName: String {
        switch self {
        case .personal: return "Personal"
        case .work: return "Work"
        case .study: return "Study"
        case .health: return "Health"
        case .other: return "Other"
        }
    }
}


struct TaskItem: Identifiable, Codable {
    var id = UUID()
    var title: String
    var isCompleted: Bool
    var createdAt: Date = Date()
    var category: TaskCategory

}
