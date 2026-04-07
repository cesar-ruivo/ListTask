import Foundation
import CoreData

protocol CoreDataProtocol {
    func saveContext()
    func createTask(title: String, description: String?, startDate: Date, endDate: Date, color: TaskColor)
    func fetchTasks<T: NSManagedObject>(_ type: T.Type, sortBy: [NSSortDescriptor]?, predicate: NSPredicate?) -> [T]
    func deleteTask<T: NSManagedObject>(_ object: T)
}
