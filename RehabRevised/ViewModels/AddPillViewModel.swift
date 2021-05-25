//
//  AddPillViewModel.swift
//  RehabRevised
//
//  Created by Joshua Basche on 5/25/21.
//

import Foundation

class AddPillViewModel: ObservableObject {
  var afternoon: Bool = false
  var dosage: String = ""
  var dosageMeasurement: String = ""
  var morning: Bool = false
  var name: String = ""
  var night: Bool = false
  var pillQuantity: String = ""
  var usage: String = ""
  
  func save() {
    
    let pill = Pill(context: Pill.viewContext)
    pill.afternoon = afternoon
    pill.dosage = dosage
    pill.dosageMeasurement = dosageMeasurement
    pill.morning = morning
    pill.name = name
    pill.night = night
    pill.pillQuantity = pillQuantity
    pill.usage = usage
    
    try? pill.save()
  }
}
