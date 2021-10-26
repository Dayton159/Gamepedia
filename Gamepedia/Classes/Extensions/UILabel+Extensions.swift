//
//  UILabel+Extensions.swift
//  Gamepedia
//
//  Created by Dayton on 27/08/21.
//

import UIKit

extension UILabel {
  func outlineText(text: String?, font: UIFont = Constants.Font.regular()) {
    let strokeTextAttributes = [
      NSAttributedString.Key.strokeColor: UIColor.black,
      NSAttributedString.Key.foregroundColor: UIColor.white,
      NSAttributedString.Key.strokeWidth: -1.0,
      NSAttributedString.Key.font: font]
      as [NSAttributedString.Key: Any]
    guard let text = text else { return }
    self.attributedText = NSMutableAttributedString(string: text, attributes: strokeTextAttributes)
  }
}
