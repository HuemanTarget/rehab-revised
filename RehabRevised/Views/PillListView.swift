//
//  PillListView.swift
//  RehabRevised
//
//  Created by Joshua Basche on 5/25/21.
//

import SwiftUI

struct PillListView: View {
  @Environment(\.managedObjectContext) var managedObjectContext
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
    .navigationBarTitle("Medication", displayMode: .inline)
    .navigationBarItems(trailing: Button(action: {
      showingAddPillView = true
    }) {
      HStack {
        Text("Add")
        
        Image(systemName: "pills")
        
      }
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
          
          Button(action: {
            //            pillListVM.addPill()
          }) {
            Text("Refill")
              .padding(8)
              .background(Color.red)
              .foregroundColor(.white)
              .clipShape(RoundedRectangle(cornerRadius: 5))
          }
          .buttonStyle(PlainButtonStyle())
        }
        
        HStack {
          Text("\(pill.usage) x per dose")
          
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
          Text("\(pill.pillQuantity) pills remaining")
          
          Spacer()
          
          Button(action: {
            //            pillListVM.addPill()
          }) {
            Image(systemName: "minus.circle")
              .resizable()
              .scaledToFit()
              .foregroundColor(.white)
              .background(Circle().fill(Color.red))
              .frame(width: 35, height: 35)
          }
          .buttonStyle(PlainButtonStyle())
          
          Text("-")
          
          Button(action: {
            //            pillListVM.addPill()
          }) {
            Image(systemName: "plus.circle")
              .resizable()
              .scaledToFit()
              .foregroundColor(.white)
              .background(Circle().fill(Color.green))
              .frame(width: 35, height: 35)
          }
          .buttonStyle(PlainButtonStyle())
        }
      }
    }
  }
  
}
