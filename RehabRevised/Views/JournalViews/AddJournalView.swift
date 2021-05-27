//
//  AddJournalView.swift
//  RehabRevised
//
//  Created by Joshua Basche on 5/25/21.
//

import SwiftUI

struct AddJournalView: View {
  
  let coreDM: CoreDataManager
  
  @StateObject private var addJournalVM = AddJournalViewModel()
  @Environment(\.presentationMode) var presentationMode
  
  @State private var journals: [Journal] = [Journal]()
  
  @State private var bpd: String = ""
  @State private var bps: String = ""
  @State private var date: Date = Date()
  @State private var hr: String = ""
  @State private var notes: String = ""
  @State private var oxygen: String = ""
  @State private var pain: String = "0"
  @State private var temperature: String = ""
  @State private var tempType: String = "°F"
  @State private var title: String = ""
  
  @State private var errorShowing: Bool = false
  @State private var errorTitle: String = ""
  @State private var errorMessage: String = ""
  
  let painLevels = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
  let temps = ["°F", "°C"]
  
  private func populateJournals() {
    journals = coreDM.getAllJournals()
  }
  
  var body: some View {
    Form {
      TextField("Journal Entry Title", text: $title)
      
      HStack {
        TextField("Heart Rate", text: $hr)
        Divider()
        TextField("Oxygen %", text: $oxygen)
      }
      .keyboardType(.numberPad)
      
      HStack {
        TextField("BP - Systolic", text: $bps)
        Divider()
        TextField("BP - Diastolic", text: $bpd)
      }
      .keyboardType(.numberPad)
      
      HStack {
        TextField("Temperature", text: $temperature)
          .keyboardType(.decimalPad)
        Picker("Temperature", selection: $tempType) {
          ForEach(temps, id: \.self) { temp in
            Text("\(temp)").tag(temp)
          }
        }
        .pickerStyle(SegmentedPickerStyle())
      }
      
      Text("Pain Level 1(low) - 10(high)")
        .font(.subheadline)
      Picker("Pain", selection: $pain) {
        ForEach(painLevels, id: \.self) {
          Text($0)
        }
      }
      .pickerStyle(SegmentedPickerStyle())
      
      TextField("Misc Notes", text: $notes)
        .padding(40)
      
      HStack {
        Spacer()
        Button("Save Journal Entry") {
          if !title.isEmpty {
            coreDM.saveJournal(title: title, bpd: bpd, bps: bps, date: date, hr: hr, notes: notes, oxygen: oxygen, pain: pain, temperature: temperature, tempType: tempType)
            populateJournals()
//            addJournalVM.save()
            presentationMode.wrappedValue.dismiss()
          } else {
            self.errorShowing = true
            self.errorTitle = "Invalid Journal Title"
            self.errorMessage = "Please enter something for\nthe journal title."
            
            return
          }
        }
        Spacer()
      }
    }
    .navigationBarTitle("Add Journal", displayMode: .inline )
    .navigationBarItems(
      trailing:
        Button(action: {
          presentationMode.wrappedValue.dismiss()
        }) {
          Image(systemName: "xmark")
        }
    )
    .embedInNavigationView()
    .alert(isPresented: $errorShowing) {
      Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("OK")))
    }
    
  }
}

//struct AddJournalView_Previews: PreviewProvider {
//  static var previews: some View {
//    AddJournalView()
//  }
//}
