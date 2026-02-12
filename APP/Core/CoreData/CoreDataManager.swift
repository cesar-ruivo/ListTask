import Foundation
import UIKit
import CoreData

final class CoreDataManager {
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
}

//MARK: - CRUD
extension CoreDataManager: CoreDataProtocol {
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
        if let descriptors: [NSSortDescriptor] = sortBy, !descriptors.isEmpty {
            fetchRequest.sortDescriptors = sortBy
        }
        
        do {
            let objects = try context.fetch(fetchRequest)
            return objects
        } catch {
            print("Erro ao buscar tarefas: \(error)")
            return []
        }
    }
    
    func deleteTask<T: NSManagedObject>(_ object: T) {
        context.delete(object)
        saveContext()
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
