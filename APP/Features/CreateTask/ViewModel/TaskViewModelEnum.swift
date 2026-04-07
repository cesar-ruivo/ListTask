import Foundation

enum TaskState {
    case hasTask
    case noHasTask
}

enum TaskField {
    case title
    case date
}

enum TaskValidationError: Error {
    case invalidDateRange
    case timeSlotOccupied
    case EmptyTitle
    
    var errorMessage: String  {
        switch self {
        case .invalidDateRange:
            return "A data de término não pode ser anterior á data de início"
        case .timeSlotOccupied:
            return "já existe uma tarefa agendada que entra em conflito com este horário"
        case .EmptyTitle:
            return "O título da tarefa não pode estar vazio"
        }
    }
}
