import Foundation

final class HomeViewModel: HomeViewModelProtocol {
    private let calendarService: CalendarServiceProtocol
    
    private var selectedDate: Date = Date()
    private var allTasks: [Task] = []
    private(set) var filteredTasks: [Task] = []
    
    private(set) var state: HomeViewState = .empty {
        didSet {
            onUpdateState?(state)
        }
    }
    private(set) var calendarDays: [CalendarDay] = [] {
        didSet {
            onUpdateCalendar?()
        }
    }
    
    var onUpdateState: ((HomeViewState) -> Void)?
    var onUpdateCalendar: (() -> Void)?
    var onError: ((String) -> Void)?
    
    init(calendarService: CalendarServiceProtocol) {
        self.calendarService = calendarService
    }
     
    func viewDidLoad() {
        fetchCalendarDays(for: selectedDate)
    }
    // MARK: - Calendario
    func fetchCalendarDays(for date: Date) {
        self.calendarDays = calendarService.getCalendar(for: selectedDate)
        filterTasks(by: date)
    }
    
    func selectDay(at index: Int) {
        guard index < calendarDays.count else { return }
        
        calendarDays.indices.forEach { dayIndex in
            calendarDays[dayIndex].isSelected = (dayIndex == index)
        }
        onUpdateCalendar?()
        
        let selectedDate: Date = calendarDays[index].date
        filterTasks(by: selectedDate)
    }
    
    private func filterTasks(by date: Date) {
        self.filteredTasks = allTasks.filter { task in
            return Calendar.current.isDate(task.date, inSameDayAs: date)
        }
        
        if filteredTasks.isEmpty {
            self.state = .empty
        } else {
            self.state = .hasTasks
        }
    }
}

