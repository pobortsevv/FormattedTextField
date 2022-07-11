//
//  FormattedTextField.swift
//  FormattedTextField
//
//  Created by sabra on 07.07.2022.
//

import SwiftUI

/// Поле ввода форматированного текста.
///
/// По сути тот же TextField, только с другой логикой форматирования
///
/// Нативное решение:
///  ```
///  init(_ title: StringProtocol, value: Binding<V>, Formatter: Formatter)
///  ```
///
/// В данной реализации formatter: (String) -> String, что позволяет нам
/// переиспользовать уже написанные функции форматирования.
///
/// Структура исключает необходимость в Presenter(если он вообще нам понадобиться в SUI)
public struct FormattedTextField: View {
  
  // MARK: Private properties
  
  private let title: String
  @Binding private var text: String
  private let formatter: (String) -> String
  
  // MARK: Init
  
  /// - Parameters:
  ///   - title: Заголовок текстового представления, описывающий его назначение.
  ///   - text: Текст для отображения и редактирования.
  ///   - formatter: Функция форматирования.
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
