import Foundation

enum TaskCategory: String, CaseIterable, Identifiable, Codable {
    case personal
    case work
    case study
    case health
    case other

    var id: String { rawValue }

    var displayName: String {
        rawValue.capitalized
    }
}


struct TaskItem: Identifiable, Codable {
    var id = UUID()
    var title: String
    var isCompleted: Bool
    var createdAt: Date = Date()
    var category: String  // ✅ Now uses String
    
    mutating func toggleCompletion() {
        isCompleted.toggle()
    }

    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: createdAt)
    }
}
