//
//  TaskEntity+CoreDataProperties.swift
//  ListTask
//
//  Created by Mag on 11/02/26.
//
//

public import Foundation
public import CoreData


public typealias TaskEntityCoreDataPropertiesSet = NSSet

extension TaskEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TaskEntity> {
        return NSFetchRequest<TaskEntity>(entityName: "TaskEntity")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var title: String?
    @NSManaged public var taskDescription: String?
    @NSManaged public var startDate: Date?
    @NSManaged public var endDate: Date?
    @NSManaged public var colorName: String?
    @NSManaged public var isDone: Bool

}

extension TaskEntity : Identifiable {

}
