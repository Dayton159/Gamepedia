//
//  Predicate.swift
//  Gamepedia
//
//  Created by Dayton on 02/09/21.
//

import Foundation

enum Predicate {
  case favorite(id: Int)

  var query: NSPredicate {
    switch self {
    case .favorite(let id):
      return NSPredicate(format: "idGame == \(id)")
    }
  }
}
