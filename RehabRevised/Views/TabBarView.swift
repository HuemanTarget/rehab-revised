//
//  TabBarView.swift
//  RehabRevised
//
//  Created by Joshua Basche on 5/25/21.
//

import SwiftUI
import CoreData

struct TabBarView: View {
  var body: some View {
    NavigationView {
      TabView {
        CalendarView()
          .tabItem {
            Label("Calendar", systemImage: "calendar")
          }
        
        PillListView()
          .tabItem {
            Label("Medication", systemImage: "pills")
          }
        
        JournalListView(coreDM: CoreDataManager())
          .tabItem {
            Label("Journal", systemImage: "book.closed")
          }
      }
      .font(.headline)
      .navigationBarTitle("Rehab", displayMode: .inline)
    }
  }
}

struct TabBarView_Previews: PreviewProvider {
  static var previews: some View {
    TabBarView()
  }
}
