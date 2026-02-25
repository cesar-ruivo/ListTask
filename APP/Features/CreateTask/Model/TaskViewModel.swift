import Foundation

final class TaskViewModel: TaskViewModelProtocol {
    private let coreDataService: CoreDataProtocol
    private let task: Task?
    private var state: TaskState
    
    init(coreDataService: CoreDataProtocol, task: Task?, ) {
        self.coreDataService = coreDataService
        self.task = task
        self.state = task == nil ? .noHasTask : .hasTask
    }
}

private extension TaskViewModel {
    func currentState(with task: Task?) -> TaskState {
        return task == nil ? .noHasTask : .hasTask
    }
}
