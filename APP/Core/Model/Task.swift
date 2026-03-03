import Foundation
import UIKit

struct Task {
    let id: UUID
    let title: String
    let description: String?
    let dateStart: Date
    let dateEnd: Date
    let colorName: TaskColor
    
    var isPast: Bool {
        return Date() > dateEnd
    }
    
    var isCurrent: Bool {
        let now = Date()
        return now >= dateStart && now <= dateEnd
    }
}

enum TaskColor: String {
    case blue, orange, yellow, currentDate
    
    var background: UIColor {
        switch self {
            case .blue: return ThemeManager.shared.getColor(named: "lightBlue") ?? UIColor(hex: "#2F1883")
            case .orange: return ThemeManager.shared.getColor(named: "lightOrange") ?? UIColor(hex: "#F6FDF9")
            case .yellow: return ThemeManager.shared.getColor(named: "lightYellow") ?? UIColor(hex: "#FFFBF1")
            case .currentDate: return ThemeManager.shared.getColor(named: "blue") ?? UIColor(hex: "#2F1883")
        }
    }
    var border: UIColor {
        switch self {
        case .blue: return ThemeManager.shared.getColor(named: "blue") ?? UIColor(hex: "#2F1883")
        case .orange: return ThemeManager.shared.getColor(named: "orange") ?? UIColor(hex: "#D87026")
        case .yellow: return ThemeManager.shared.getColor(named: "yellow") ?? UIColor(hex: "#D29706")
        case .currentDate: return ThemeManager.shared.getColor(named: "blue") ?? UIColor(hex: "#2F1883")
        }
    }
    
    var titleAndDateColor: UIColor {
        switch self {
        case .blue, .orange, .yellow: return ThemeManager.shared.getColor(named: "textColorPrimary") ?? UIColor(hex: "#080C3A")
        case .currentDate: return ThemeManager.shared.getColor(named: "white") ?? UIColor(hex: "#FFFFFF")
        }
    }
    
    var descriptionColor: UIColor {
        switch self {
        case .blue, .orange, .yellow: return ThemeManager.shared.getColor(named: "textColorSecondary") ?? UIColor(hex: "#9598B1")
        case .currentDate: return ThemeManager.shared.getColor(named: "white") ?? UIColor(hex: "#FFFFFF")
        }
    }
}

