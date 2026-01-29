import Foundation

protocol CalendarServiceProtocol {
    func getDaysInMonth(for date: Date) -> [Date]
    func getCalendar(for today: Date) -> [CalendarDay]
    func getYear(for date: Date) -> String
    func getMonthName(for date: Date) -> String
    func getRelativeMonthName(for date: Date, offset: Int) -> String
}
