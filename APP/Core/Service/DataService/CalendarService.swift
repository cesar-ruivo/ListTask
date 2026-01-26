import Foundation

class CalendarService: CalendarServiceProtocol {
    private let calendar = Calendar.current
    
    func getDaysInMoth(for date: Date) -> [Date] {
        guard let range = calendar.range(of: .day, in: .month, for: date) else {
            return []
        }
        
        let components = calendar.dateComponents([.year, .month], from: date)
        
        guard let startOfMonth = calendar.date(from: components) else {
            return []
        }
        
        var days: [Date] = []
        
        for day in range {
            if let newDate = calendar.date(byAdding: .day, value: day - 1, to: startOfMonth) {
                days.append(newDate)
            }
        }
        
        return days
    }
}
