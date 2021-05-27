//
//  AuthenticationView.swift
//  RehabRevised
//
//  Created by Joshua Basche on 5/26/21.
//

import SwiftUI
import LocalAuthentication

struct AuthenticationView: View {
  @State var isUnlocked: Bool = false
  
  var body: some View {
    VStack {
      if isUnlocked {
        ContentView()
      } else {
        Button(action: {
          auth()
        }) {
          Image(systemName: "faceid")
            .font(.largeTitle)
        }
      }
    }
  }
  
  func auth() {
    let context = LAContext()
    var error: NSError?
    if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
      let reason = "We need your biometics authentication to enter the app."
      context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) { success, authenticationError in
        DispatchQueue.main.async {
          if success {
            isUnlocked = true
          } else {
            print("You are not the owner!")
          }
        }
      }
    } else {
      print("No FaceID")
    }
  }
}

struct AuthenticationView_Previews: PreviewProvider {
  static var previews: some View {
    AuthenticationView()
  }
}
