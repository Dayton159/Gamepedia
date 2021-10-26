//
//  String+Extensions.swift
//  Gamepedia
//
//  Created by Dayton on 28/08/21.
//

import Foundation

extension String {
  func removeHTMLTags() -> String? {
    guard let htmlStringData = self.data(using: String.Encoding.utf8) else {
      return nil
    }
    let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
      .documentType: NSAttributedString.DocumentType.html,
      .characterEncoding: String.Encoding.utf8.rawValue
    ]
    let attributedString = try? NSAttributedString(data: htmlStringData, options: options, documentAttributes: nil)
    return attributedString?.string
  }
}
