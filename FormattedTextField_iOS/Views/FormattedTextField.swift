//
//  FormattedTextField.swift
//  FormattedTextField
//
//  Created by sabra on 07.07.2022.
//

import SwiftUI

public struct FormattedTextField: View {
  
  // MARK: Private properties
  
  private let title: String
  @Binding private var text: String
  private let formatter: (String) -> String
  
  // MARK: Init
  
  init(_ title: String, text: Binding<String>, formatter: @escaping (String) -> String) {
    self.title = title
    self._text = text
    self.formatter = formatter
  }

  // MARK: - Body
  
  public var body: some View {
    TextField(title, text: Binding(get: { formatter(text) },
                                   set: { self.text = $0 }))
  }
}
