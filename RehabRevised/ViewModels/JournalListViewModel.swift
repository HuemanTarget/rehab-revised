//
//  JournalListViewModel.swift
//  RehabRevised
//
//  Created by Joshua Basche on 5/25/21.
//

import Foundation
import CoreData

class JournalListViewModel: NSObject, ObservableObject {
  
  @Published var journals = [JournalViewModel]()
  
  private var fetchedResultsController: NSFetchedResultsController<Journal>!
  
  func deleteJournal(journal: JournalViewModel) {
    let journal: Journal? = Journal.byId(id: journal.journalId)
    if let journal = journal {
      try? journal.delete()
    }
  }
  
  func getAllJournals() {
    
    let request: NSFetchRequest<Journal> = Journal.fetchRequest()
    request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
    fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataManager.shared.viewContext, sectionNameKeyPath: nil, cacheName: nil)
    try? fetchedResultsController.performFetch()
    
    DispatchQueue.main.async {
      self.journals = (self.fetchedResultsController.fetchedObjects ?? []).map(JournalViewModel.init)
    }
  }
}

extension JournalListViewModel: NSFetchedResultsControllerDelegate {
  func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    DispatchQueue.main.async {
      self.journals = (controller.fetchedObjects as? [Journal] ?? []).map(JournalViewModel.init)
    }
  }
}

struct JournalViewModel {
  
  let journal: Journal
  
  var journalId: NSManagedObjectID {
    return journal.objectID
  }
  
  var title: String {
    return journal.title ?? ""
  }
  
  var bpd: String {
    return journal.bpd ?? ""
  }
  
  var bps: String {
    return journal.bps ?? ""
  }
  
  var hr: String {
    return journal.hr ?? ""
  }
  
  var notes: String {
    return journal.notes ?? ""
  }
  
  var oxygen: String {
    return journal.oxygen ?? ""
  }
  
  var date: String? {
    return journal.date?.asFormattedString()
  }
  
  var pain: String {
    return journal.pain ?? ""
  }
  
  var temperature: String {
    return journal.temperature ?? ""
  }
  
  var tempType: String {
    return journal.tempType ?? ""
  }
  
}
