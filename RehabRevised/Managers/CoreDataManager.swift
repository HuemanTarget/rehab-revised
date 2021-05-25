//
//  CoreDataManager.swift
//  RehabRevised
//
//  Created by Joshua Basche on 5/25/21.
//

import Foundation
import SwiftUI
import CoreData

class CoreDataManager {
  
  let persistentContainer: NSPersistentContainer
  
  static let shared = CoreDataManager()
  
  init() {
    
    persistentContainer = NSPersistentContainer(name: "Rehab")
    persistentContainer.loadPersistentStores { (description, error) in
      
      if let error = error {
        fatalError("Failed to initialize Core Data \(error)")
      }
    }
    
    let directories = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
    print(directories[0])
  }
  
  var viewContext: NSManagedObjectContext {
    return persistentContainer.viewContext
  }
}