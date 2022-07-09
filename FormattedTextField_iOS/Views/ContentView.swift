//
//  ContentView.swift
//  FormattedTextField_iOS
//
//  Created by sabra on 07.07.2022.
//

import SwiftUI

struct ContentView: View {
  @State var text: String = ""
  
  var body: some View {
    FormattedTextField("Проверка", text: $text, formatter: inputFormatAsRuPhone)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
