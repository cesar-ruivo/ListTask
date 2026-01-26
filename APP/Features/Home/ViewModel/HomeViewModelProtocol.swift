import Foundation

protocol HomeViewModelProtocol {
    var calendarDays: [calendarDay] { get }
    var onUpdateCalendar: (() -> Void)? { get set }
    var onError: ((String) -> Void)? { get set } 
    
    func viewDidLoad()
    func fetchCalendarDays()
    func selectDay(at index: Int)
}
