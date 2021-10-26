//
//  Reusable.swift
//  Gamepedia
//
//  Created by Dayton on 24/08/21.
//

import Foundation
import UIKit

public protocol Reusable: AnyObject {
  static var reuseIdentifier: String { get }
  static var nib: UINib? { get }
}

public extension Reusable {
  static var reuseIdentifier: String {
    String(describing: self)
  }

  static var nib: UINib? { UINib(nibName: String(describing: self), bundle: nil) }
}
