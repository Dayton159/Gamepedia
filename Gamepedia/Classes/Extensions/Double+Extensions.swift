//
//  Double+Extensions.swift
//  Gamepedia
//
//  Created by Dayton on 25/08/21.
//

import Foundation

extension Double {
  func toString() -> String? {
    return String(format: "%.1f", self)
  }
}
