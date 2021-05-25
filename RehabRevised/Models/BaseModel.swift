//
//  BaseModel.swift
//  RehabRevised
//
//  Created by Joshua Basche on 5/25/21.
//

import Foundation
import CoreData

protocol BaseModel: NSManagedObject {
  func save() throws
  func delete() throws
  static func byID<T: NSManagedObject>(id: NSManagedObjectID) -> T?
  static func all<T: NSManagedObject>() -> [T]
}

extension BaseModel {
  static var viewContext: NSManagedObjectContext {
    return CoreDataManager.shared.viewContext
  }
  
  func save() {
    do {
      try Self.viewContext.save()
    } catch {
      print(error)
    }
  }
  
  func delete() throws {
    Self.viewContext.delete(self)
    try save()
  }
  
  static func all<T>() -> [T] where T: NSManagedObject {
    
    let fetchRequest: NSFetchRequest<T> = NSFetchRequest(entityName: String(describing: T.self))
    
    do {
      return try viewContext.fetch(fetchRequest)
    } catch {
      return []
    }
  }
  
  static func byId<T>(id: NSManagedObjectID) -> T? where T: NSManagedObject {
    
    do {
      return try viewContext.existingObject(with: id) as? T
    } catch {
      return nil
    }
  }
}
