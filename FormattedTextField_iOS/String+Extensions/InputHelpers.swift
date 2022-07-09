//
//  InputHelpers.swift
//  FormattedTextField_iOS
//
//  Created by sabra on 09.07.2022.
//

import Foundation

extension String {
  /// Удалятся все символы (Unicode Scalar'ы) кроме символов из указанного CharacterSet. Например все кроме цифр
  public func removingCharacters(except characterSet: CharacterSet) -> String {
    let scalars = unicodeScalars.filter(characterSet.contains(_:))
    return String(scalars)
  }
  
  /// Удалятся все символы (Unicode Scalar'ы), которые соответствуют указанному CharacterSet.
  /// Например все точки и запятые
  public func removingCharacters(in characterSet: CharacterSet) -> String {
    let scalars = unicodeScalars.filter { !characterSet.contains($0) }
    return String(scalars)
  }
}

public enum Ctn: Namespace {
  /// Длина CTN 10 символов. например: 9657891212
  public static let length: Int = 10

  /// "+7"
  public static let ruCountryCode: String = "+7"
  
  /// ["3", "4", "8", "9"]
  /// Коды городов, начинающиеся на 3, 4, 8, 9. Например 495, 499, 925
  public static let cityCodePrefixesRu: Set<String> = ["3", "4", "8", "9"]
}

extension CharacterSet {
  /// "0123456789"
  public static let arabicNumerals = CharacterSet(charactersIn: "0123456789")
  /// Символы, корректные для номера телефона: "0123456789+-()*#"
  public static let phoneNumberSymbols = arabicNumerals.union(CharacterSet(charactersIn: "+-()*#"))
  /// Символы, допустимые для ввода номера телефона в текстовом поле: phoneNumberSymbols + пробел
  public static let phoneNumberInputSymbols = phoneNumberSymbols.union(CharacterSet(charactersIn: " "))
}

extension StringProtocol {
  public func containsCharacters(except characterSet: CharacterSet) -> Bool {
    let inverted = characterSet.inverted
    return unicodeScalars.contains(where: { inverted.contains($0) })
  }
}

/// Набор чистых функций для очистки лишних символов при чтении строк из текстовых полей
public enum TextualInput: Namespace {
  /// Метод для предварительной обработки строки, взятой из текстового поля.
  /// Предназначен для случаев, когда в текстовом поле может быть ввдён только CTN
  /// Удаляет всё кроме цифр и ограничивает получившуюся строку по длине до 10 символов
  public static func refinedCtnRawString(_ rawString: String) -> String {
    let refined: String = rawString.removingCharacters(except: .arabicNumerals)
    
    let rawCtnLength: Int = Ctn.length + 1 // добавляем +1 символ, т.к пользователь может вводить код страны (7 или 8)
    
    return String(refined.prefix(rawCtnLength))
  }
}
