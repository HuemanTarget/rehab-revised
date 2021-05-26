//
//  PillListView.swift
//  RehabRevised
//
//  Created by Joshua Basche on 5/25/21.
//

import SwiftUI
import CoreData

struct PillListView: View {
  
  @StateObject private var pillListVM = PillListViewModel()
  
  @State private var showingAddPillView: Bool = false
  
  private func deletePill(at indexSet: IndexSet) {
    indexSet.forEach { index in
      let pill = pillListVM.pills[index]
      pillListVM.deletePill(pill: pill)
      pillListVM.getAllPills()
    }
  }
  
  var body: some View {
    List {

      ForEach(pillListVM.pills, id: \.pillId) { pill in
        PillCell(pill: pill)
      }
      .onDelete(perform: deletePill)
    }
    .listStyle(PlainListStyle())
    .navigationTitle("Medication Entries")
    .navigationBarItems(trailing: Button("Add Medication") {
      showingAddPillView = true
    })
    .sheet(isPresented: $showingAddPillView, onDismiss: {
      pillListVM.getAllPills()
    }, content: {
      AddPillView()
    })
    .embedInNavigationView()
    
    .onAppear(perform: {
      pillListVM.getAllPills()
    })
  }
}

struct PillListView_Previews: PreviewProvider {
  static var previews: some View {
    PillListView()
  }
}

struct PillCell: View {
  
  @Environment(\.managedObjectContext) var managedObjectContext
  @FetchRequest(entity: Pill.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Pill.name, ascending: true)]) var pills: FetchedResults<Pill>
  
  let pill: PillViewModel
  
  var body: some View {
    HStack {
      VStack(alignment: .leading) {
        HStack {
          Text(pill.name)
            .font(.title2)
            .fontWeight(.bold)
          Text(" - ")
            .font(.title2)
            .fontWeight(.bold)
          Text(pill.dosage)
            .font(.subheadline)
            .fontWeight(.bold)
          Text(pill.dosageMeasurement)
            .font(.subheadline)
            .fontWeight(.bold)
          
          Spacer()
          
          Button("Refill") {
            let pill = Pill(context: Pill.viewContext)
            let quantity = Int(pill.pillQuantity!)
            let refill = String(quantity! + 30)
            
            pill.pillQuantity = refill
            pill.save()
          }
        }
        
        HStack {
          Text(pill.usage)
          
          Spacer()
          
          Text(pill.morning ? "morning" : "")
            .font(.subheadline)
            .fontWeight(.bold)
          
          Text(pill.afternoon ? "noon" : "")
            .font(.subheadline)
            .fontWeight(.bold)
          
          Text(pill.night ? "night" : "")
            .font(.subheadline)
            .fontWeight(.bold)
          
          Spacer()
        }
        
        HStack {
          Text(pill.pillQuantity)
          
          Spacer()
          
          Button(action: {
//            pillListVM.minusPill()
          }) {
            Image(systemName: "minus.circle")
              .resizable()
              .scaledToFit()
          }
          
          Text("-")
          
          Button(action: {
//            pillListVM.addPill()
          }) {
            Image(systemName: "plus.circle")
              .resizable()
              .scaledToFit()
          }
        }
      }
    }
  }
  
}
