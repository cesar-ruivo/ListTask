import Foundation
import UIKit

final class TaskBuilder {
    func build(with task: Task?) -> UIViewController {
        let coreDataService: CoreDataManager = CoreDataManager()
        
        let viewModel: TaskViewModel = TaskViewModel(coreDataService: coreDataService, task: task)
        let view: TaskViewController = TaskViewController(viewModel: viewModel)
        
        return view
    }
}
