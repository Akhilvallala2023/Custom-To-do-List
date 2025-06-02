//
//  TaskItem.swift
//  To do list
//
//  Created by Akhil Vallala on 6/1/25.
//

import Foundation

struct TaskItem: Identifiable, Codable {
    var id = UUID()
    var title: String
    var isCompleted: Bool
}
