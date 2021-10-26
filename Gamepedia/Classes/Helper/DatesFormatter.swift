//
//  DatesFormatter.swift
//  Gamepedia
//
//  Created by Dayton on 25/08/21.
//

import Foundation

extension Foundation.DateFormatter {
    @nonobjc static var standardDateFormatter: Foundation.DateFormatter = {
        let dateFormatter = Foundation.DateFormatter()
        return dateFormatter
    }()

    static func dateFormatter(_ format: String) -> Foundation.DateFormatter {
        let dateFormatter = standardDateFormatter
        dateFormatter.dateFormat = format
        return dateFormatter
    }
}

enum DatesFormatter {
  case dashMode
  case yearOnBack

  func formatter() -> Foundation.DateFormatter {
    switch self {
    case .dashMode:
      return dateFormatter(string: "yyyy-MM-dd")
    case .yearOnBack:
      return dateFormatter(string: "dd MMM yyyy")
    }
  }

  private func dateFormatter(string: String) -> Foundation.DateFormatter {
      let localFormatter = Foundation.DateFormatter.dateFormatter(string)
      localFormatter.locale = Locale.current
      return localFormatter
  }

  func stringFromDate(_ date: Date) -> String {
      return self.formatter().string(from: date)
  }

  func dateFromString(_ string: String) -> Date? {
      return self.formatter().date(from: string)
  }
}
