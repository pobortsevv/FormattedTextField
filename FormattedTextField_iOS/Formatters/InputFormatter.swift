//
//  InputFormatter.swift
//  FormattedTextField_iOS
//
//  Created by sabra on 09.07.2022.
//

import Foundation

public func inputFormatAsRuPhone(_ string: String) -> String {
  formatAsRuPhone(string) ?? string.removingCharacters(except: .phoneNumberInputSymbols)
}

public func formatAsRuPhone(_ string: String) -> String? {
  format(phoneString: string, cityCodePrefixes: Ctn.cityCodePrefixesRu, countryCode: Ctn.ruCountryCode)
}

/// Приватный метод для форматирования номеров телефона или ШПД
fileprivate func format(phoneString: String, cityCodePrefixes: Set<String>, countryCode: String?) -> String? {
  // Преподготаливаем строку и удяляем пробелы
  let phoneString: String = phoneString.removingCharacters(in: .whitespacesAndNewlines)
  
  // Если содержатся буквы или другие символы то это не номер телефона. Скорее всего, пользователь вводит
  // циферно буквенный логин. Проверяем это, и если есть символы отличные от номера телефона то возвращаем nil
  // Это даст понимание коду, который вызывает этот метод, что строка не является номером телефона
  guard !phoneString.containsCharacters(except: .phoneNumberInputSymbols) else { return nil }
  
  // Удаляем все символы кроме чисел. Это упрощает написанный ниже алгоритм
  let digits: String = TextualInput.refinedCtnRawString(phoneString)
  
  var remained = Substring(digits) // Необработанные символы
  
  guard let first: Character = remained.first else { return nil }
  
  // Country Code
  if first == "7" {
    remained = remained.dropFirst(1) // Удаляем 7 из remained
  }
  
  var numberComponents: [String] = []
  
  if let countryCode: String = countryCode {
    numberComponents.append(countryCode)
  }
  
  // City Code. Забираем первые 3 цифры из remained.
  do {
    let cityCodeLength: Int = 3
    let cityCode = String(remained.prefix(cityCodeLength)) //
    remained = remained.dropFirst(cityCodeLength)
    
    // Проверяем что cityCode начинается c допусттимых цифр
    // Напимер с 6, 7 или 9 для номера телефона или 082, 085, 089 для ШПД
    let isValidCityCode: Bool = cityCodePrefixes.contains { cityCode.hasPrefix($0) }
    
    guard isValidCityCode else { return nil }
    
    numberComponents.append(cityCode)
  }
  
  let makeNumberFrom: (_ components: [String]) -> String = { $0.joined(separator: " ") }
  
  let partsLengths: [Int] = [3, 2, 2] // Номр в формате "*** ** **"
  
  /* Из оставшихся цифр формируем номер телефона.
   Цикл обработает первые 7 цифр номера из remained. Оставшиеся цифры в numberComponents не попадут */
  for length in partsLengths {
    guard !remained.isEmpty else { return makeNumberFrom(numberComponents) }
    let part = String(remained.prefix(length))
    remained = remained.dropFirst(length)
    
    numberComponents.append(part)
  }
  
  return makeNumberFrom(numberComponents)
}
