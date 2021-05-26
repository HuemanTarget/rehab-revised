//
//  PrimaryButtonStyle.swift
//  RehabRevised
//
//  Created by Joshua Basche on 5/26/21.
//

import Foundation
import SwiftUI

struct PrimaryButtonStyle: ButtonStyle {
  
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .padding()
      .background(Color.blue)
      .foregroundColor(.white)
      .clipShape(RoundedRectangle(cornerRadius: 5))
  }
}
