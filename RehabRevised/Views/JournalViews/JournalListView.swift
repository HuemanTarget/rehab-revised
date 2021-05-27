//
//  JournalListView.swift
//  RehabRevised
//
//  Created by Joshua Basche on 5/25/21.
//

import SwiftUI

struct JournalListView: View {
  
  let coreDM: CoreDataManager
  
  @StateObject private var journalListVM = JournalListViewModel()
  
  @State private var showingAddJournalView: Bool = false
  @State private var needsRefresh: Bool = false
  @State private var journals: [Journal] = [Journal]()
  
  var dateFormatter: DateFormatter {
    let formatter = DateFormatter()
    formatter.dateStyle = .long
    formatter.timeStyle = .short
    return formatter
  }
  
  private func populateJournals() {
    journals = coreDM.getAllJournals()
//    print(movies[0].title ?? "")
  }
  
  private func deleteJournal(at indexSet: IndexSet) {
    indexSet.forEach { index in
      let journal = journalListVM.journals[index]
      journalListVM.deleteJournal(journal: journal)
      journalListVM.getAllJournals()
    }
  }
  
//  private func getAllJournals() {
//    journalListVM.getAllJournals()
//  }
  
  var body: some View {
    List {
      
      ForEach(journals, id: \.self) { journal in
        NavigationLink(destination: JournalDetailView(journal: journal, coreDM: coreDM, needsRefresh: $needsRefresh),
        label: {
          VStack(alignment: .leading) {
      //      Text("\(journal.date ?? Date(), formatter: self.dateFormatter)")
            Text("\(journal.date!)")
              .font(.subheadline)
            Text(journal.title ?? "")
              .padding(.bottom, 2)
              .font(.title)
            
            HStack {
              Text("HR: \(journal.hr ?? "")")
              
              Spacer()
              
              Text("BP: \(journal.bps ?? "") / \(journal.bpd ?? "")" )
              
              Spacer()
              
              Text("Pain Level: \(journal.pain ?? "")")
            }
            .padding(.bottom, 2)
            .font(.subheadline)
            
            HStack {
              Text("Temp: \(journal.temperature ?? "") \(journal.tempType ?? "")")
              
              Spacer()
              
              Text("Oxygen: \(journal.oxygen ?? "")%")
              
              Spacer()
            }
            .padding(.bottom, 2)
            .font(.subheadline)
            
            Text("Notes: \(journal.notes ?? "")")
              .padding(.bottom, 2)
          }

        })
      }
      .onDelete(perform: deleteJournal)
      
    }
    .listStyle(PlainListStyle())
    .accentColor(needsRefresh ? .white : .black)
    .navigationBarTitle("Journal", displayMode: .inline)
    .navigationBarItems(trailing: Button(action: {
      showingAddJournalView = true
    }) {
      HStack {
        Text("Add")
        
        Image(systemName: "book.closed")
          
      }
    })
    .sheet(isPresented: $showingAddJournalView, onDismiss: {
      journalListVM.getAllJournals()
    }, content: {
      AddJournalView(coreDM: CoreDataManager())
    })
    .embedInNavigationView()
    
    .onAppear(perform: {
      populateJournals()
    })
  }
}

//struct JournalListView_Previews: PreviewProvider {
//  static var previews: some View {
//    JournalListView()
//  }
//}

//struct JournalCell: View {
//  
//  let journal: JournalViewModel;
//  
//  var body: some View {
//    VStack(alignment: .leading) {
////      Text("\(journal.date ?? Date(), formatter: self.dateFormatter)")
//      Text(journal.date!)
//        .font(.subheadline)
//      Text(journal.title)
//        .padding(.bottom, 2)
//        .font(.title)
//      
//      HStack {
//        Text("HR: \(journal.hr)")
//        
//        Spacer()
//        
//        Text("BP: \(journal.bps) / \(journal.bpd)" )
//        
//        Spacer()
//        
//        Text("Pain Level: \(journal.pain)")
//      }
//      .padding(.bottom, 2)
//      .font(.subheadline)
//      
//      HStack {
//        Text("Temp: \(journal.temperature) \(journal.tempType)")
//        
//        Spacer()
//        
//        Text("Oxygen: \(journal.oxygen)%")
//        
//        Spacer()
//      }
//      .padding(.bottom, 2)
//      .font(.subheadline)
//      
//      Text("Notes: \(journal.notes)")
//        .padding(.bottom, 2)
//    }
//  }
//}
