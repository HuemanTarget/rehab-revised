//
//  JournalDetailView.swift
//  RehabRevised
//
//  Created by Joshua Basche on 5/27/21.
//

import SwiftUI

struct JournalDetailView: View {
  
  let journal: Journal
  let coreDM: CoreDataManager
  @Binding var needsRefresh: Bool

  @Environment(\.presentationMode) var presentationMode
  
  @State private var bpdName: String = ""
  @State private var bpsName: String = ""
  @State private var date: Date = Date()
  @State private var hrName: String = ""
  @State private var notesName: String = ""
  @State private var oxygenName: String = ""
  @State private var painName: String = "0"
  @State private var temperatureName: String = ""
  @State private var tempTypeName: String = "°F"
  @State private var titleName: String = ""
  
  @State private var errorShowing: Bool = false
  @State private var errorTitle: String = ""
  @State private var errorMessage: String = ""
  
  
  let painLevels = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
  let temps = ["°F", "°C"]
  
  var body: some View {
    Form {
      TextField(journal.title ?? "", text: $titleName)
      
      HStack {
        TextField(journal.hr ?? "", text: $hrName)
        Divider()
        TextField(journal.oxygen ?? "", text: $oxygenName)
      }
      .keyboardType(.numberPad)
      
      HStack {
        TextField(journal.bps ?? "", text: $bpsName)
        Divider()
        TextField(journal.bpd ?? "", text: $bpdName)
      }
      .keyboardType(.numberPad)
      
      HStack {
        TextField(journal.temperature ?? "", text: $temperatureName)
          .keyboardType(.decimalPad)
        Picker("Temperature", selection: $tempTypeName) {
          ForEach(temps, id: \.self) { temp in
            Text("\(temp)").tag(temp)
          }
        }
        .pickerStyle(SegmentedPickerStyle())
      }
      
      Text("Pain Level 1(low) - 10(high)")
        .font(.subheadline)
      Picker("Pain", selection: $painName) {
        ForEach(painLevels, id: \.self) {
          Text($0)
        }
      }
      .pickerStyle(SegmentedPickerStyle())
      
      TextField(journal.notes ?? "", text: $notesName)
        .padding(40)
      
      HStack {
        Spacer()
        Button("Update Journal Entry") {
          if !titleName.isEmpty {
            journal.bpd = bpdName
            journal.bps = bpsName
            journal.date = date
            journal.hr = hrName
            journal.notes = notesName
            journal.oxygen = oxygenName
            journal.pain = painName
            journal.temperature = temperatureName
            journal.tempType = tempTypeName
            journal.title = titleName
            coreDM.updateJournal()
            needsRefresh.toggle()
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
//    .navigationBarTitle("Add Journal", displayMode: .inline )
//    .navigationBarItems(
//      trailing:
//        Button(action: {
//          presentationMode.wrappedValue.dismiss()
//        }) {
//          Image(systemName: "xmark")
//        }
//    )
//    .embedInNavigationView()
    .alert(isPresented: $errorShowing) {
      Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("OK")))
    }
    
  }
}


//struct JournalDetailView_Previews: PreviewProvider {
//  static var previews: some View {
//    JournalDetailView()
//  }
//}
