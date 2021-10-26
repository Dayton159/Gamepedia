//
//  Defaults.swift
//  Gamepedia
//
//  Created by Dayton on 04/09/21.
//

import Foundation

@propertyWrapper
struct Defaults<T: Codable> {
  private let key: String
  private let defaultValue: T

  init(key: String, defaultValue: T) {
    self.key = key
    self.defaultValue = defaultValue
  }

  var wrappedValue: T {
    get {
      guard let data = UserDefaults.standard.object(forKey: key) as? Data else { return defaultValue }

      let value = try? JSONDecoder().decode(T.self, from: data)
      return value ?? defaultValue
    }
    set {
      let data = try? JSONEncoder().encode(newValue)

      UserDefaults.standard.set(data, forKey: key)
    }
  }
}
