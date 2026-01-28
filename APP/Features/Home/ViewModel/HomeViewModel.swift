import Foundation

final class HomeViewModel: HomeViewModelProtocol {
    private let calendarService: CalendarServiceProtocol
    
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
        
    }
    // MARK: - Calendario
    func fetchCalendarDays() {
        let today = Date()
        
        let rawDates = calendarService.getDaysInMoth(for: today)
        
        let dayFormatter = DateFormatter()
        dayFormatter.dateFormat = "dd"
        
        let weekDayFormatter = DateFormatter()
        weekDayFormatter.dateFormat = "EEE"
        weekDayFormatter.locale = Locale(identifier: "pt_BR")
        
        self.calendarDays = rawDates.map { date in
            let dayNumber = dayFormatter.string(from: date)
            let weekDay = weekDayFormatter.string(from: date)
            let isSelected = Calendar.current.isDate(date, inSameDayAs: today)
            
            return CalendarDay(date: date, dayNumber: dayNumber, WeekDay: weekDay.uppercased(), isSelected: isSelected)
        }
    }
    
    func selectDay(at index: Int) {
        guard index < calendarDays.count else { return }
        
        for day in 0..<calendarDays.count {
            calendarDays[day].isSelected = (day == index)
        }
        onUpdateCalendar?()
        
        let selectedDate = calendarDays[index].date
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

