//
//  Journal+Extension.swift
//  RehabRevised
//
//  Created by Joshua Basche on 5/25/21.
//

import Foundation
import CoreData

extension Journal: BaseModel {
  static func byID<T>(id: NSManagedObjectID) -> T? where T : NSManagedObject {
    do {
      return try viewContext.existingObject(with: id) as? T
    } catch {
      return nil
    }
  }
  
  
  
}
