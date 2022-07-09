//
//  ContentView.swift
//  FormattedTextField_iOS
//
//  Created by sabra on 07.07.2022.
//

import SwiftUI

class Profile: ObservableObject {
  @Published var phone: String = ""
}

struct ContentView: View {
  @ObservedObject var profile = Profile()
  @State private var showModal = false
  
  var body: some View {
    HStack {
      Text(profile.phone).padding()
      Button("Изменить", action: {
        showModal = true
      }).sheet(isPresented: $showModal) {
        PhoneNumberInputView(phone: $profile.phone)
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
