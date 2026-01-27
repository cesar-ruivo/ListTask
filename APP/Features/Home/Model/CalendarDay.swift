import Foundation

struct Task {
    let title: String
    let subtitle: String
    let date: Date
    let isComplete: Bool
}

struct CalendarDay {
    let date: Date
    let dayNumber: String
    let WeekDay: String
    var isSelected: Bool
}
