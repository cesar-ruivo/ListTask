import Foundation

protocol TaskViewModelProtocol {
    var onError: ((String) -> Void)? { get set }
    var onFieldError: ((TaskField, String) -> Void)? { get }
    
    func validateAndSaveTask(title: String, startDate: Date, endDate: Date, color: TaskColor, description: String?)
}
