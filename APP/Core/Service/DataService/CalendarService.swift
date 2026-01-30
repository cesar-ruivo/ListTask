import Foundation

final class CalendarService: CalendarServiceProtocol {
    private let calendar: Calendar = Calendar.current
    
    private let dayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd"
        return formatter
    }()
    
    private let weekDayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE"
        formatter.locale = Locale.current
        return formatter
    }()
    
    private let monthFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM"
        formatter.locale = Locale.current
        return formatter
    }()
    
    private let yearFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        return formatter
    }()
    
    func getDaysInMonth(for date: Date) -> [Date] {
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
    
    func getCalendar(for today: Date) -> [CalendarDay] {
        let rawDates: [Date] = self.getDaysInMonth(for: today)
        
        return rawDates.map { date in
            let dayNumber: String = dayFormatter.string(from: date)
            let weekDay: String = weekDayFormatter.string(from: date)
            let isSelected: Bool = self.calendar.isDate(date, inSameDayAs: today)
            
            return CalendarDay(date: date, dayNumber: dayNumber, weekDay: weekDay.uppercased(), isSelected: isSelected)
        }
    }
    
    func getMonthName(for date: Date) -> String {
        return monthFormatter.string(from: date)
    }
    
    func getRelativeMonthName(for date: Date, offset: Int) -> String {
        guard let relativeDate = calendar.date(byAdding: .month, value: offset, to: date) else { return "" }
        return monthFormatter.string(from: relativeDate).capitalized
    }
    
    func getYear(for date: Date) -> String {
        return yearFormatter.string(from: date)
    }
}
