//
//  AddJournalViewModel.swift
//  RehabRevised
//
//  Created by Joshua Basche on 5/25/21.
//

import Foundation

class AddJournalViewModel: ObservableObject {
  
  var bpd: String = ""
  var bps: String = ""
  var date: Date = Date()
  var hr: String = ""
  var notes: String = ""
  var oxygen: String = ""
  var pain: String = "N/A"
  var temperature: String = ""
  var tempType: String = "°F"
  var title: String = ""
  
  func save() {
    
    let journal = Journal(context: Journal.viewContext)
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
    
    try? journal.save()
  }
  
}
