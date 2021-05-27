//
//  JournalDetailViewModel.swift
//  RehabRevised
//
//  Created by Joshua Basche on 5/27/21.
//

import Foundation

class JournalDetailViewModel: ObservableObject {
  
  
  var bpdName: String = ""
  var bpsName: String = ""
  var date: Date = Date()
  var hrName: String = ""
  var notesName: String = ""
  var oxygenName: String = ""
  var painName: String = "0"
  var temperatureName: String = ""
  var tempTypeName: String = "°F"
  var titleName: String = ""
  
//  func update() {
//
////    let journal = Journal(context: Journal.viewContext)
//    journal.bpd = bpdName
//    journal.bps = bpsName
//    journal.date = date
//    journal.hr = hrName
//    journal.notes = notesName
//    journal.oxygen = oxygenName
//    journal.pain = painName
//    journal.temperature = temperatureName
//    journal.tempType = tempTypeName
//    journal.title = titleName
//
//    journal.update()
//  }
}
