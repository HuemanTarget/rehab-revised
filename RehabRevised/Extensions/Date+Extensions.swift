//
//  Date+Extension.swift
//  RehabRevised
//
//  Created by Joshua Basche on 5/25/21.
//

import Foundation

extension Date {
  func asFormattedString() -> String {
    let formatter = DateFormatter()
    formatter.dateStyle = .long
    formatter.timeStyle = .short
    return formatter.string(from: self)
  }
}
