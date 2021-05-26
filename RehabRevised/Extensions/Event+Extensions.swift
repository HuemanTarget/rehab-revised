//
//  Event+Extensions.swift
//  RehabRevised
//
//  Created by Joshua Basche on 5/26/21.
//

import EventKit
import SwiftUI

extension EKEvent {
  var color: Color {
    return Color(UIColor(cgColor: self.calendar.cgColor))
  }
}
