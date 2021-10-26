//
//  Constants.swift
//  Gamepedia
//
//  Created by Dayton on 24/08/21.
//

import UIKit

struct Constants {
  struct Image {
    static let placeholder = UIImage(named: "image_default")
    static let emptyView = UIImage(named: "empty_view")
    static let home = UIImage(systemName: "house")
    static let homeFill = UIImage(systemName: "house.fill")
    static let about = UIImage(systemName: "person")
    static let aboutFill = UIImage(systemName: "person.circle")
    static let favorite = UIImage(systemName: "heart")
    static let favoriteFill = UIImage(systemName: "heart.fill")
    static let bookmark = UIImage(systemName: "bookmark")
    static let bookmarkFill = UIImage(systemName: "bookmark.fill")
    static let edit = UIImage(systemName: "square.and.pencil")
  }

  struct PngData {
    static func profileImgData() -> Data {
      guard let data = UIImage(named: "profile_picture")?.pngData()
      else { fatalError("Failed to convert image to data")}

      return data
    }
  }

  struct Color {
    static let cell = UIColor(named: "cellColor")
    static let background = UIColor(named: "bgColor")
    static let navigation = UIColor(named: "navColor")
  }

  struct Font {

    static func light(_ size: CGFloat = 12) -> UIFont {
      guard let font = UIFont(name: "Lato-Light", size: size) else { fatalError("Lato-Light Not Found")}
      return font
    }

    static func regular(_ size: CGFloat = 12) -> UIFont {
      guard let font = UIFont(name: "Lato-Regular", size: size) else { fatalError("Lato-Regular Not Found")}
      return font
    }

    static func semibold(_ size: CGFloat = 12) -> UIFont {
      guard let font = UIFont(name: "Lato-Semibold", size: size) else { fatalError("Lato-Semibold Not Found")}
      return font
    }

    static func bold(_ size: CGFloat = 12) -> UIFont {
      guard let font = UIFont(name: "Lato-Bold", size: size) else { fatalError("Lato-Bold Not Found")}
      return font
    }
  }
}
