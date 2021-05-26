//
//  AddPillView.swift
//  RehabRevised
//
//  Created by Joshua Basche on 5/25/21.
//

import SwiftUI

struct AddPillView: View {
  
  @StateObject private var addPillVM = AddPillViewModel()
  @Environment(\.presentationMode) var presentationMode
  
  @State private var morning: Bool = false
  @State private var noon: Bool = false
  @State private var night: Bool = false
  @State private var pillQuantity: String = ""
  
  @State private var errorShowing: Bool = false
  @State private var errorTitle: String = ""
  @State private var errorMessage: String = ""
  
  let mesurements = [ "mg", "mL" ]
  
  let hapticImpact = UIImpactFeedbackGenerator(style: .medium)
  
  var body: some View {
    Form {
      TextField("Medication Name", text: $addPillVM.name)
      
      HStack {
        TextField("Dosage", text: $addPillVM.dosage)
        
        Spacer ()
        
        Picker("Dosage Measurement", selection: $addPillVM.dosageMeasurement) {
          ForEach(mesurements, id: \.self) { dose in
            Text("\(dose)").tag(dose)
          }
        }
        .pickerStyle(SegmentedPickerStyle())
      }
      
      HStack {
        TextField("Per Dose", text: $addPillVM.dosage)
          .keyboardType(.decimalPad)
        
        Divider()
        
        
        
        Toggle(isOn: $addPillVM.morning) {
          Text("Morning")
            .font(.subheadline)
        }
        .toggleStyle(CheckboxStyle())
        
        Spacer()
        
        Toggle(isOn: $addPillVM.afternoon) {
          Text("Noon")
            .font(.subheadline)
        }
        .toggleStyle(CheckboxStyle())
        
        Spacer()
        
        Toggle(isOn: $addPillVM.night) {
          Text("Night")
            .font(.subheadline)
        }
        .toggleStyle(CheckboxStyle())
      }
      
      TextField("Quantity", text: $addPillVM.pillQuantity)
        .keyboardType(.numberPad)
      
      HStack {
        Spacer()
        Button("Save Medication") {
          if self.pillQuantity == "" {
            pillQuantity = "0"
          }
          
          if self.addPillVM.name != "" {
//            let pill = Pill(context: self.managedObjectContext)
//            pill.morning = self.morning
//            pill.afternoon = self.noon
//            pill.night = self.night
//            pill.pillQuantity = self.pillQuantity
//
//            try? self.managedObjectContext.save()
            addPillVM.save()
            presentationMode.wrappedValue.dismiss()
          } else {
            self.errorShowing = true
            self.errorTitle = "Invalid Medication Name"
            self.errorMessage = "Please enter something for\nthe medication name."
            
            return
          }
        }
        Spacer()
      }
    }
    .navigationBarTitle("Add Medication", displayMode: .inline )
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

struct AddPillView_Previews: PreviewProvider {
  static var previews: some View {
    AddPillView()
  }
}
