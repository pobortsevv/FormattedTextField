//
//  FormattedTextField.swift
//  FormattedTextField
//
//  Created by sabra on 07.07.2022.
//

import SwiftUI

public struct FormattedTextField: View {
  init(_ title: String, text: Binding<String>, formatter: @escaping (String) -> String) {
    self.title = title
    self._text = text
    self.formatter = formatter
  }
  
  let title: String
  @Binding var text: String
  let formatter: (String) -> String
  
  public var body: some View {
    TextField(title, text: Binding(get: { formatter(text) },
                                   set: { self.text = $0 }))
  }
}
