//
//  ErrorModel.swift
//  Gamepedia
//
//  Created by Dayton on 25/08/21.
//

import Foundation

struct ErrorModel: Codable {
  private let error: String?

  init(error: String?) {
    self.error = error
  }

  static func setErrorMessage(error: APIServiceError) -> ErrorModel {
    return ErrorModel(error: error.errorMessage)
  }

  var getErrorMessage: String {
    return error ?? "Error Occured"
  }
}
