//
//  String+Extensions.swift
//  RehabRevised
//
//  Created by Joshua Basche on 5/25/21.
//

import Foundation

extension String {
  func asDate() -> Date? {
    let formatter = DateFormatter()
    formatter.dateFormat = "MM/dd/yyyy"
    return formatter.date(from: self)
  }
}
