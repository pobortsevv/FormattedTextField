//
//  Binding+Extensions.swift
//  FormattedTextField_iOS
//
//  Created by sabra on 09.07.2022.
//

import Combine
import SwiftUI

extension Binding {
  /// Необходим, если мы хотим замокать @Binding значение в preview
  static func mock(_ value: Value) -> Self {
    var value = value
    return Binding(get: { value }, set: { value = $0 })
  }
}
