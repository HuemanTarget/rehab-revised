//
//  AddJournalView.swift
//  RehabRevised
//
//  Created by Joshua Basche on 5/25/21.
//

import SwiftUI

struct AddJournalView: View {
  
  @StateObject private var addJournalVM = AddJournalViewModel()
  @Environment(\.presentationMode) var presentationMode
  
  @State private var errorShowing: Bool = false
  @State private var errorTitle: String = ""
  @State private var errorMessage: String = ""
  
  let painLevels = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
  let temps = ["°F", "°C"]
  
  var body: some View {
    Form {
      TextField("Journal Entry Title", text: $addJournalVM.title)
      
      HStack {
        TextField("Heart Rate", text: $addJournalVM.hr)
        Divider()
        TextField("Oxygen %", text: $addJournalVM.oxygen)
      }
      .keyboardType(.numberPad)
      
      HStack {
        TextField("BP - Systolic", text: $addJournalVM.bps)
        Divider()
        TextField("BP - Diastolic", text: $addJournalVM.bpd)
      }
      .keyboardType(.numberPad)
      
      HStack {
        TextField("Temperature", text: $addJournalVM.temperature)
          .keyboardType(.decimalPad)
        Picker("Temperature", selection: $addJournalVM.tempType) {
          ForEach(temps, id: \.self) { temp in
            Text("\(temp)").tag(temp)
          }
        }
        .pickerStyle(SegmentedPickerStyle())
      }
      
      Text("Pain Level 1(low) - 10(high)")
        .font(.subheadline)
      Picker("Pain", selection: $addJournalVM.pain) {
        ForEach(painLevels, id: \.self) {
          Text($0)
        }
      }
      .pickerStyle(SegmentedPickerStyle())
      
      TextField("Misc Notes", text: $addJournalVM.notes)
        .padding(40)
      
      HStack {
        Spacer()
        Button("Save Journal Entry") {
          if self.addJournalVM.title != "" {
            addJournalVM.save()
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

struct AddJournalView_Previews: PreviewProvider {
  static var previews: some View {
    AddJournalView()
  }
}
