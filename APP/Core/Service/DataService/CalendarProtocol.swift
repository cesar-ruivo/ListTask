import Foundation

protocol CalendarServiceProtocol {
    func getDaysInMoth(for date: Date) -> [Date]
}
