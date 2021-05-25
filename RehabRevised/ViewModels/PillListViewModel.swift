//
//  PillListViewModel.swift
//  RehabRevised
//
//  Created by Joshua Basche on 5/25/21.
//

import Foundation
import CoreData

class PillListViewModel: NSObject, ObservableObject {
  
  @Published var pills = [PillViewModel]()
  
  private var fetchedResultsController: NSFetchedResultsController<Pill>!
  
  func deletePill(pill: PillViewModel) {
    let pill: Pill? = Pill.byId(id: pill.pillId)
    if let pill = pill {
      try? pill.delete()
    }
  }
  
  func minusPill() {
    
    let pill = Pill(context: Pill.viewContext)
    let quantity = Int(pill.pillQuantity ?? "0")
    let minus = String(quantity! - 1)
    
    pill.pillQuantity = minus
    
    try? pill.save()
  }
  
  func addPill() {
    
    let pill = Pill(context: Pill.viewContext)
    let quantity = Int(pill.pillQuantity ?? "0")
    let minus = String(quantity! + 1)
    
    pill.pillQuantity = minus
    
    try? pill.save()
  }
  
  func refillPill() {
    
    let pill = Pill(context: Pill.viewContext)
    let quantity = Int(pill.pillQuantity ?? "0")
    let minus = String(quantity! + 30)
    
    pill.pillQuantity = minus
    
    try? pill.save()
  }
  
  func getAllPills() {
    
    let request: NSFetchRequest<Pill> = Pill.fetchRequest()
    request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
    fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataManager.shared.viewContext, sectionNameKeyPath: nil, cacheName: nil)
    try? fetchedResultsController.performFetch()
    
    DispatchQueue.main.async {
      self.pills = (self.fetchedResultsController.fetchedObjects ?? []).map(PillViewModel.init)
    }
  }
}

extension PillListViewModel: NSFetchedResultsControllerDelegate {
  func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    DispatchQueue.main.async {
      self.pills = (controller.fetchedObjects as? [Pill] ?? []).map(PillViewModel.init)
    }
  }
}

struct PillViewModel {
  
  let pill: Pill
  
  var pillId: NSManagedObjectID {
    return pill.objectID
  }
  
  var name: String {
    return pill.name ?? ""
  }
  
  var afternoon: Bool {
    return pill.afternoon
  }
  
  var dosage: String {
    return pill.dosage ?? ""
  }
  
  var dosageMeasurement: String {
    return pill.dosageMeasurement ?? ""
  }
  
  var morning: Bool {
    return pill.morning
  }
  
  var night: Bool {
    return pill.night
  }
  
  var pillQuantity: String {
    return pill.pillQuantity ?? ""
  }
  
  var usage: String {
    return pill.usage ?? ""
  }
  
}
