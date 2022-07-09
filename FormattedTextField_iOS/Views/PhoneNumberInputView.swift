//
//  PhoneNumberInputView.swift
//  FormattedTextField_iOS
//
//  Created by sabra on 09.07.2022.
//

import SwiftUI

struct PhoneNumberInputView: View {
  @Environment(\.presentationMode) var presentation
  @Binding var phone: String
  
  var body: some View {
    VStack {
      FormattedTextField("Проверка", text: $phone, formatter: inputFormatAsRuPhone)
        .padding()
      Button("Dismiss") {
        self.presentation.wrappedValue.dismiss()
      }
    }
  }
}

struct PhoneNumberInputView_Previews: PreviewProvider {
  static var previews: some View {
    PhoneNumberInputView(phone: .mock(""))
  }
}
