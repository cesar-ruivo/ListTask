import Foundation

final class HomeViewModel: HomeViewModelProtocol {
    private let calendarService: CalendarServiceProtocol
    
    private(set) var days: [CalendarDay]
    
    private(set) var calendarDays: [CalendarDay] = [] {
        didSet {
            onUpdateCalendar?()
        }
    }
    
    var onUpdateCalendar: (() -> Void)?
    var onError: ((String) -> Void)?
    
    init(calendarService: CalendarServiceProtocol) {
        self.calendarService = calendarService
    }
     
    func viewDidLoad() {
        
    }
    // MARK: - Calendario
    func fetchCalendarDays() {
        let hoje: Date = Date()
        let datasCruas: [Date] = calendarService.getDaysInMoth(for: hoje)
        self.days = datasCruas.map { date in
        }
    }
    
    func selectDay(at index: Int) {
        
    }
}

