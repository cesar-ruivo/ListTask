import Foundation

protocol HomeViewModelProtocol {
    var calendarDays: [CalendarDay] { get }
    var onUpdateCalendar: (() -> Void)? { get set }
    var onError: ((String) -> Void)? { get set } 
    
    func viewDidLoad()
    func fetchCalendarDays(for date: Date)
    func selectDay(at index: Int)
}
