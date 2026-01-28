import Foundation

final class CalendarService: CalendarServiceProtocol {
    private let calendar: Calendar = Calendar.current
    
    func getDaysInMoth(for date: Date) -> [Date] {
        guard let range: Range<Int> = calendar.range(of: .day, in: .month, for: date) else {
            return []
        }
        
        let components: DateComponents = calendar.dateComponents([.year, .month], from: date)
        
        guard let startOfMonth: Date = calendar.date(from: components) else {
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
