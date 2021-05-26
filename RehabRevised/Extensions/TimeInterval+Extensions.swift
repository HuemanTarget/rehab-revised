//
//  TimeInterval+Extensions.swift
//  RehabRevised
//
//  Created by Joshua Basche on 5/26/21.
//

import Foundation


extension TimeInterval {
  static func weeks(_ weeks: Double) -> TimeInterval {
    return weeks * TimeInterval.week
  }
  
  static var week: TimeInterval {
    return 7 * 24 * 60 * 60
  }
}
