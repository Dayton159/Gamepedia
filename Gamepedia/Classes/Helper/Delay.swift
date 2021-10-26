//
//  Delay.swift
//  Gamepedia
//
//  Created by Dayton on 27/08/21.
//

import Foundation

struct Delay {
  static func wait(delay: Double = 0.5, completion: @escaping() -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
      completion()
    }
  }

  static func execute(completion: @escaping() -> Void) {
    DispatchQueue.main.async {
      completion()
    }
  }
}
