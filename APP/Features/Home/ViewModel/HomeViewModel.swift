import Foundation

final class HomeViewModel: HomeViewModelProtocol {
    private let calendarService: CalendarServiceProtocol
    private let coreData: CoreDataProtocol
    
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
    init(calendarService: CalendarServiceProtocol, coreData: CoreDataProtocol) {
        self.calendarService = calendarService
        self.coreData = coreData
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
                
        self.selectedDate = calendarDays[index].date
        filterTasks(by: self.selectedDate)
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
    //MARK: - Calendar
    func filterTasks(by date: Date) {
        let selectDay = calendarService.resetCalendar(by: date)
        
        self.filteredTasks = allTasks.filter { task in
            let start = calendarService.resetCalendar(by: task.dateStart)
            let end = calendarService.resetCalendar(by: task.dateEnd)
            
            return selectDay >= start && selectDay <= end
        }
        
        state = filteredTasks.isEmpty ? .empty: .hasTasks
    }
    
    func updateData(for date: Date) {
        self.selectedDate = date
        
        self.calendarDays = calendarService.getCalendar(for: date)
        
        self.currentMonth = calendarService.getMonthName(for: date)
        self.currentYear = calendarService.getYear(for: date)
        self.previousMonth = calendarService.getRelativeMonthName(for: date, offset: -1)
        self.nextMonth = calendarService.getRelativeMonthName(for: date, offset: 1)
        
        onUpdateHeader?()
        fetchAndConvertTasks()
        filterTasks(by: date)
    }
    //MARK: - CoreData
    func fetchAndConvertTasks() {
        let sortRules = [NSSortDescriptor(key: "startDate", ascending: true)]
        let entities = coreData.fetchTasks(TaskEntity.self, sortBy: sortRules)
        
        self.allTasks = entities.map { entity in
    
            return Task(id: entity.id ?? UUID(),
                        title: entity.title ?? "Sem Titulo",
                        description: entity.taskDescription,
                        dateStart: entity.startDate ?? Date(),
                        dateEnd: entity.endDate ?? Date(),
                        colorName: TaskColor(rawValue: entity.colorName ?? "") ?? .blue)
        }
    }
}

