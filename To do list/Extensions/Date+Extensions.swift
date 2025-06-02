//
//  Date+Extensions.swift
//  To do list
//
//  Created by Akhil Vallala on 6/1/25.
//

import Foundation

extension Date {
    
    /// Returns the date as a formatted string like "May 30, 2025"
    func formattedString() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter.string(from: self)
    }

    /// Returns time in "HH:mm a" format like "10:45 AM"
    func formattedTime() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        return formatter.string(from: self)
    }

    /// Returns relative time string like "2 hours ago"
    func timeAgoDisplay() -> String {
        let interval = Date().timeIntervalSince(self)
        let minutes = Int(interval / 60)
        if minutes < 60 {
            return "\(minutes) minutes ago"
        } else if minutes < 1440 {
            return "\(minutes / 60) hours ago"
        } else {
            return "\(minutes / 1440) days ago"
        }
    }
}
