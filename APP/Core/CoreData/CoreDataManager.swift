import Foundation
import UIKit
import CoreData

final class CoreDataManager {
    static let shared: CoreDataManager = CoreDataManager()
    
    private init() {}
    
    lazy var presistentContainer: NSPersistentContainer = {
        let conteiner = NSPersistentContainer(name: "TaskManagerModel")
        conteiner.loadPersistentStores { (storeDescription, error) in
            if let error  = error as NSError? { fatalError("Erro ao carregar Core Data: \(error), \(error.userInfo)") }
        }
        
        return conteiner
    }()
    
    var context: NSManagedObjectContext {
        return presistentContainer.viewContext
    }
    
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Erro ao salvar: \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

//MARK: - CRUD
extension CoreDataManager {
    func createTask(title: String, description: String?, startDate: Date, endDate: Date, color: TaskColor) {
        let newTask: TaskEntity = TaskEntity(context: context)
        
        newTask.id = UUID()
        newTask.title = title
        newTask.taskDescription = description
        newTask.startDate = startDate
        newTask.endDate = endDate
        newTask.colorName = color.rawValue
        newTask.isDone = false
        
        saveContext()
    }
    
    func fetchTasks<T: NSManagedObject>(_ type: T.Type, sortBy: [NSSortDescriptor]? = nil) -> [T] {
        let entityName: String = String(describing: type)
        
        let fetchRequest: NSFetchRequest<T> = NSFetchRequest<T>(entityName: entityName)
        fetchRequest.sortDescriptors = sortBy
        
        do {
            let objects = try context.fetch(fetchRequest)
            return objects
        } catch {
            print("Erro ao buscar tarefas: \(error)")
            return []
        }
    }
    
    func deleteTask(_ task: TaskEntity) {
        context.delete(task)
        saveContext()
    }
}
