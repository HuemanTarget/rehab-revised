//
//  ContentView.swift
//  RehabRevised
//
//  Created by Joshua Basche on 5/25/21.
//

import SwiftUI

struct ContentView: View {
  
  @AppStorage("agreed") var userAgreed: Bool?
  @State private var displayPopupMessage: Bool = true
  
  var body: some View {
    if userAgreed ?? false {
      TabBarView()
    } else {
      VStack {
        TabBarView()
      }
      .alert(isPresented: $displayPopupMessage){
        Alert(title: Text("User Agreement"), message: Text("This app is for personal use only and should not be used for medical advice. Please consult your doctor for any medical questions or issues."), dismissButton: .default(Text("Agree"), action: {
          let agree: Bool = true
          userAgreed = agree
        })
        )
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
