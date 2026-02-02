import Foundation

final class HomeViewModel: HomeViewModelProtocol {
    private let calendarService: CalendarServiceProtocol
    
    //tarefas
    private var allTasks: [Task] = []
    private(set) var filteredTasks: [Task] = []
    
    //calendario
    private var selectedDate: Date = Date()
    private(set) var calendarDays: [CalendarDay] = [] {
        didSet {
            onUpdateCalendar?()
        }
    }
    
    private(set) var state: HomeViewState = .empty {
        didSet {
            onUpdateState?(state)
        }
    }
    
    //variaveis de texto
    private(set) var currentMonth: String = ""
    private(set) var previousMonth: String = ""
    private(set) var nextMonth: String = ""
    private(set) var currentYear: String = ""
    
    var onUpdateState: ((HomeViewState) -> Void)?
    var onUpdateCalendar: (() -> Void)?
    var onUpdateHeader: (() -> Void)?
    var onError: ((String) -> Void)?
    
    //MARK: - Inicializador
    init(calendarService: CalendarServiceProtocol) {
        self.calendarService = calendarService
    }
     
    func viewDidLoad() {
        updateData(for: selectedDate)
    }
}

//MARK: - Metodos
extension HomeViewModel {
    // MARK: - Calendario
    func selectDay(at index: Int) {
        guard index < calendarDays.count else { return }
        
        calendarDays.indices.forEach { dayIndex in
            calendarDays[dayIndex].isSelected = (dayIndex == index)
        }
        onUpdateCalendar?()
                
        let selectedDate: Date = calendarDays[index].date
        filterTasks(by: selectedDate)
    }
    
    func getNextMonth() {
        guard let newDate = Calendar.current.date(byAdding: .month, value: 1, to: selectedDate) else { return }
        updateData(for: newDate)
    }
    
    func getPreviousMonth() {
        guard let newDate = Calendar.current.date(byAdding: .month, value: -1, to: selectedDate) else { return }
        updateData(for: newDate)
    }
    
    func getNextYear() {
        guard let newDate = Calendar.current.date(byAdding: .year, value: 1, to: selectedDate) else { return }
        updateData(for: newDate)
    }
    
    func getPreviousYear() {
        guard let newDate = Calendar.current.date(byAdding: .year, value: -1, to: selectedDate) else { return }
        updateData(for: newDate)
    }
}

//MARK: - Metodos privados
private extension HomeViewModel {
    func filterTasks(by date: Date) {
        self.filteredTasks = allTasks.filter { task in
            return Calendar.current.isDate(task.date, inSameDayAs: date)
        }
        
        state = filteredTasks.isEmpty ? .empty: .hasTasks
        
//        if filteredTasks.isEmpty {
//            self.state = .empty
//        } else {
//            self.state = .hasTasks
//        }
    }
    
    func updateData(for date: Date) {
        self.selectedDate = date
        
        self.calendarDays = calendarService.getCalendar(for: date)
        
        self.currentMonth = calendarService.getMonthName(for: date)
        self.currentYear = calendarService.getYear(for: date)
        self.previousMonth = calendarService.getRelativeMonthName(for: date, offset: -1)
        self.nextMonth = calendarService.getRelativeMonthName(for: date, offset: 1)
        
        onUpdateHeader?()
        filterTasks(by: date)
    }
}

