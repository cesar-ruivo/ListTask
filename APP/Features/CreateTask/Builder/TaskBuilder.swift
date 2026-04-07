import Foundation
import UIKit

final class TaskBuilder {
    func build(with task: Task?) -> UIViewController {
        let coreDataService: CoreDataManager = CoreDataManager()
        let calendarService: CalendarService = CalendarService()
        
        let viewModel: TaskViewModel = TaskViewModel(coreDataService: coreDataService, task: task, calendarService: calendarService)
        let view: TaskViewController = TaskViewController(viewModel: viewModel)
        
        return view
    }
}
