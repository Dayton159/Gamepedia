//
//  GameDetailModel.swift
//  Gamepedia
//
//  Created by Dayton on 26/08/21.
//

import Foundation

struct GameDetailModel: Codable {
  let description: String?
  let genres: [Genre]?
}

struct Genre: Codable {
  let name: String?
}

struct GameDetail {
  let general: GameResult
  let detail: GameDetailModel

  init(_ general: GameResult, _ detail: GameDetailModel) {
    self.general = general
    self.detail = detail
  }
}
