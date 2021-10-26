//
//  GameModel.swift
//  Gamepedia
//
//  Created by Dayton on 25/08/21.
//

import Foundation

struct GameModel: Codable {
  let results: [GameResult]?
}

struct GameResult: Codable {
  let idGame: Int?
  let name, image: String?
  let released: Date?
  let rating: Double?

  enum CodingKeys: String, CodingKey {
    case rating
    case name, released
    case idGame = "id"
    case image = "background_image"
  }

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)

    let stringDate = try? container.decode(String.self, forKey: .released)

    self.idGame = try? container.decode(Int.self, forKey: .idGame)
    self.name = try? container.decode(String.self, forKey: .name)
    self.rating = try? container.decode(Double.self, forKey: .rating)
    self.image = try? container.decode(String.self, forKey: .image)
    self.released = DatesFormatter.dashMode.dateFromString(stringDate ?? "")
  }

  init(idGame: Int?, name: String?, image: String?, released: Date?, rating: Double?) {
    self.idGame = idGame
    self.name = name
    self.image = image
    self.released = released
    self.rating = rating
  }
}
