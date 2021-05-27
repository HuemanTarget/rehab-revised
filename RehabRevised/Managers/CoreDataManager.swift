//
//  CoreDataManager.swift
//  RehabRevised
//
//  Created by Joshua Basche on 5/25/21.
//

import Foundation
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
  
  func updateJournal() {
    
    do {
      try persistentContainer.viewContext.save()
    } catch {
      persistentContainer.viewContext.rollback()
    }
    
  }
  
  func getAllJournals() -> [Journal] {
    
    let fetchRequest: NSFetchRequest<Journal> = Journal.fetchRequest()
    
    do {
      return try persistentContainer.viewContext.fetch(fetchRequest)
    } catch {
      return []
    }
    
  }
  
  func saveJournal(title: String, bpd: String, bps: String, date: Date, hr: String, notes: String, oxygen: String, pain: String, temperature: String, tempType: String) {
    
    let journal = Journal(context: persistentContainer.viewContext)
    journal.bpd = bpd
    journal.bps = bps
    journal.date = date
    journal.hr = hr
    journal.notes = notes
    journal.oxygen = oxygen
    journal.pain = pain
    journal.temperature = temperature
    journal.tempType = tempType
    journal.title = title
    
    do {
      try persistentContainer.viewContext.save()
      print("Movie Saved")
    } catch {
      print("Failed to save movie \(error)")
    }
    
  }
  
  func deleteJournal(journal: Journal) {
    
    persistentContainer.viewContext.delete(journal)
    
    do {
      try persistentContainer.viewContext.save()
    } catch {
      persistentContainer.viewContext.rollback()
      print("Failed to save context \(error.localizedDescription)")
    }
    
  }
  
}
