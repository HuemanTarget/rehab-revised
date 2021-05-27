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
  @State var noAuth: Bool = false
  @State private var willMoveToNextScreen = false
  
  var body: some View {
      VStack {
        Text("Please Authenticate Using")
          .padding(.bottom, 50)
          .font(.headline)
        
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
        
        if noAuth {
            Button(action: {
              willMoveToNextScreen = true
            }) {
              Text("Press To Enter \n Without Authentication")
                .multilineTextAlignment(.center)
            }
            .padding(.top, 20)
          
        }
      }.navigate(to: ContentView(), when: $willMoveToNextScreen)
    
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
      noAuth = true
    }
  }
}

extension View {
  
  /// Navigate to a new view.
  /// - Parameters:
  ///   - view: View to navigate to.
  ///   - binding: Only navigates when this condition is `true`.
  func navigate<NewView: View>(to view: NewView, when binding: Binding<Bool>) -> some View {
    NavigationView {
      ZStack {
        self
          .navigationBarTitle("")
          .navigationBarHidden(true)
        
        NavigationLink(
          destination: view
            .navigationBarTitle("")
            .navigationBarHidden(true),
          isActive: binding
        ) {
          EmptyView()
        }
      }
    }
  }
}

struct AuthenticationView_Previews: PreviewProvider {
  static var previews: some View {
    AuthenticationView()
  }
}
