//
//  SecondaryCaptionTextStyle.swift
//  RehabRevised
//
//  Created by Joshua Basche on 5/26/21.
//

import Foundation
import SwiftUI

struct SecondaryCaptionTextStyle: ViewModifier {
  func body(content: Content) -> some View {
    content
      .font(.caption)
      .foregroundColor(.secondary)
  }
}
