//
//  AddPillView.swift
//  RehabRevised
//
//  Created by Joshua Basche on 5/25/21.
//

import SwiftUI

struct AddPillView: View {
  
  @StateObject private var addPillVM = AddPillViewModel()
  @Environment(\.presentationMode) var presentationMode
  
  @State private var errorShowing: Bool = false
  @State private var errorTitle: String = ""
  @State private var errorMessage: String = ""
  
  var body: some View {
    Form {
      
    }
  }
}

struct AddPillView_Previews: PreviewProvider {
  static var previews: some View {
    AddPillView()
  }
}
