import Foundation

class HomeViewModel: HomeViewModelProtocol {
    private let networkService: NetworkServiceProtocol
    private let calendarService: CalendarServiceProtocol
    
    private(set) var days: [CalendarDay]
    
    private(set) var calendarDays: [CalendarDay] = [] {
        didSet {
            onUpdateCalendar?()
        }
    }
    
    var onUpdateCalendar: (() -> Void)?
    var onError: ((String) -> Void)?
    
    init(networkService: NetworkServiceProtocol, calendarService: CalendarServiceProtocol) {
        self.networkService = networkService
        self.calendarService = calendarService
    }
     
    func viewDidLoad() {
        
    }
    // MARK: - Calendario
    func fetchCalendarDays() {
        let hoje = Date()
        let datasCruas = calendarService.getDaysInMoth(for: hoje)
        self.days = datasCruas.map { date in
        }
    }
    
    func selectDay(at index: Int) {
        
    }
}

