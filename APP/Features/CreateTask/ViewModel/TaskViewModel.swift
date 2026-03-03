import Foundation

final class TaskViewModel: TaskViewModelProtocol  {
    private let coreDataService: CoreDataProtocol
    private let calendarService: CalendarServiceProtocol
    private let task: Task?
    private var state: TaskState
    
    var onError: ((String) -> Void)?
    var onFieldError: ((TaskField, String) -> Void)?
    
    init(coreDataService: CoreDataProtocol, task: Task?,calendarService: CalendarServiceProtocol ) {
        self.coreDataService = coreDataService
        self.calendarService = calendarService
        self.task = task
        self.state = task == nil ? .noHasTask : .hasTask
    }
}

extension TaskViewModel {
    func validateAndSaveTask(title: String, startDate: Date, endDate: Date, color: TaskColor, description: String?) {
        guard title.trimmingCharacters(in: .whitespaces).count > 0 else {
            onError?(TaskValidationError.EmptyTitle.errorMessage)
            return
        }
        
        guard startDate <= endDate else {
            onError?(TaskValidationError.invalidDateRange.errorMessage)
            return
        }
        
        if hasTimeConflict(newStart: startDate, newEnd: endDate) {
            onFieldError?(.date, TaskValidationError.timeSlotOccupied.errorMessage)
            return
        }
        
        if state == .noHasTask {
            coreDataService.createTask(title: title, description: description, startDate: startDate, endDate: endDate, color: color)
            return
        } else {
            updateTask(title: title, startDate: startDate, endDate: endDate, color: color, description: description)
        }
    }
}

private extension TaskViewModel {
    func hasTimeConflict(newStart: Date, newEnd: Date) -> Bool {
        let predicate = NSPredicate(format: "endDate >= %@ AND startDate < %@", newStart as NSDate, newEnd as NSDate)
        let conflictingEntities = coreDataService.fetchTasks(TaskEntity.self, sortBy: nil, predicate: predicate)
        
        let realConflict = conflictingEntities.filter { entity in
            return (entity.id == self.task?.id) == false
        }
        return realConflict.count > 0
    }
    
    func updateTask(title: String, startDate: Date, endDate: Date, color: TaskColor, description: String?) {
        guard let taskToUpdate = self.task else { return }
                
        let predicate = NSPredicate(format: "id == %@", taskToUpdate.id as CVarArg)
        let results = coreDataService.fetchTasks(TaskEntity.self, sortBy: nil, predicate: predicate)
                
        guard let entityToUpdate = results.first else { return }
                
        entityToUpdate.title = title
        entityToUpdate.taskDescription = description
        entityToUpdate.startDate = startDate
        entityToUpdate.endDate = endDate
        entityToUpdate.colorName = color.rawValue
                
        coreDataService.saveContext()
    }
}
