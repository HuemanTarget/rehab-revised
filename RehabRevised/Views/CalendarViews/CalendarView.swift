//
//  CalendarView.swift
//  RehabRevised
//
//  Created by Joshua Basche on 5/25/21.
//

import SwiftUI
import EventKit
import Combine

struct CalendarView: View {
  enum ActiveSheet {
    case calendarChooser
    case calendarEdit
  }
  
  @State private var showingSheet = false
  @State private var activeSheet: ActiveSheet = .calendarEdit
  
  @ObservedObject var eventsRepository = EventsRepository.shared
  
  @State private var selectedEvent: EKEvent?
  
  func showEditFor(_ event: EKEvent) {
    activeSheet = .calendarEdit
    selectedEvent = event
    showingSheet = true
  }
  
  var body: some View {
    NavigationView {
      VStack {
        List {
          if eventsRepository.events?.isEmpty ?? true {
            Text("No upcoming events")
              .font(.headline)
              .foregroundColor(.secondary)
          }
          
          ForEach(eventsRepository.events ?? [], id: \.self) { event in
            EventRow(event: event).onTapGesture {
              self.showEditFor(event)
            }
          }
        }
        
        SelectedCalendarsList(selectedCalendars: Array(eventsRepository.selectedCalendars ?? []))
          .padding(.vertical)
          .padding(.horizontal, 5)
        
        Button(action: {
          self.activeSheet = .calendarChooser
          self.showingSheet = true
        }) {
          Text("Select Calendars")
        }
        .buttonStyle(PrimaryButtonStyle())
        .font(.system(size: 14, weight: .bold, design: .default))
        .frame(width: 150, height: 50)
        .cornerRadius(9)
        .foregroundColor(.white)
        .padding(.bottom, 20)
        .sheet(isPresented: $showingSheet) {
          if self.activeSheet == .calendarChooser {
            CalendarChooser(calendars: self.$eventsRepository.selectedCalendars, eventStore: self.eventsRepository.eventStore)
          } else {
            EventEditView(eventStore: self.eventsRepository.eventStore, event: self.selectedEvent)
          }
        }
      }
      .navigationBarTitle("Calendar", displayMode: .inline)
      .navigationBarItems(trailing: Button(action: {
        self.selectedEvent = nil
        self.activeSheet = .calendarEdit
        self.showingSheet = true
      }, label: {
        //Image(systemName: "plus").frame(width: 44, height: 44)
        HStack {
          Text("Add")
          
          Image(systemName: "calendar")
          
        }
      }))
    }
  }
}

// MARK: - PREVIEW
struct CalendarView_Previews: PreviewProvider {
  static var previews: some View {
    CalendarView()
  }
}
