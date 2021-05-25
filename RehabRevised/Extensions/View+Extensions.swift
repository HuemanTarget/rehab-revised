//
//  View+Extension.swift
//  RehabRevised
//
//  Created by Joshua Basche on 5/25/21.
//

import Foundation
import SwiftUI

extension View {
  func embedInNavigationView() -> some View {
    NavigationView { self }
  }
}
