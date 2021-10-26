//
//  UIImageView+Extensions.swift
//  Gamepedia
//
//  Created by Dayton on 25/08/21.
//

import UIKit
import Kingfisher

extension UIImageView {
  func setImageFrom(url: String?) {
    let supportSpace = url?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    self.kf.setImage(with: convertToURL(urlString: supportSpace), placeholder: Constants.Image.placeholder, options: [.cacheMemoryOnly, .transition(.fade(0.5))])
  }

  private func convertToURL(urlString: String?) -> URL? {
    guard let safeUrlString = urlString,
          let url = URL(string: safeUrlString) else { return nil}
    return url
  }
}
