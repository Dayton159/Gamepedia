//
//  Validation.swift
//  Gamepedia
//
//  Created by Dayton on 04/09/21.
//

import UIKit

protocol Validation {
  var isValid: Bool { get }
  func validate(_ button: UIButton)
}
