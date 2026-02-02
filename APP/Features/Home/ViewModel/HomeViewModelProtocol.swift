import Foundation

protocol HomeViewModelProtocol {
    var calendarDays: [CalendarDay] { get }
    var onUpdateCalendar: (() -> Void)? { get set }
    var onError: ((String) -> Void)? { get set }
    var onUpdateHeader: (() -> Void)? { get set } 
    var onUpdateState: ((HomeViewState) -> Void)? { get set }
    
    var currentMonth: String { get }
    var currentYear: String { get }
    var previousMonth: String { get }
    var nextMonth: String { get }
    
    func viewDidLoad()
//    func fetchCalendarDays(for date: Date)
    func selectDay(at index: Int)
    func getNextMonth()
    func getPreviousMonth()
    func getNextYear()
    func getPreviousYear()
    
}
