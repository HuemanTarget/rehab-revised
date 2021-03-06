//
//  EventRow.swift
//  RehabRevised
//
//  Created by Joshua Basche on 5/26/21.
//

import SwiftUI
import EventKit

struct EventRow: View {
  let event: EKEvent
  
  private static var relativeDateFormatter: RelativeDateTimeFormatter = {
    let formatter = RelativeDateTimeFormatter()
    formatter.dateTimeStyle = .named
    return formatter
  }()
  
  private static var dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.timeStyle = .short
    return formatter
  }()
  
  private static func formatDate(forNonAllDayEvent event: EKEvent) -> String {
    return "\(EventRow.dateFormatter.string(from: event.startDate)) - \(EventRow.dateFormatter.string(from: event.endDate))"
  }
  
  var body: some View {
    HStack {
      Circle()
        .fill(event.color)
        .frame(width: 10, height: 10, alignment: .center)
      
      
      VStack(alignment: .leading) {
        Text(EventRow.relativeDateFormatter.localizedString(for: event.startDate, relativeTo: Date()).uppercased())
          .modifier(SecondaryCaptionTextStyle())
          .padding(.bottom, 2)
        Text(event.title)
          .font(.headline)
      }
      
      Spacer()
      
      VStack {
        Spacer()
        Text(event.isAllDay ? "all day" : EventRow.formatDate(forNonAllDayEvent: event))
          .modifier(SecondaryCaptionTextStyle())
      }
    }.padding(.vertical, 5)
  }
}
