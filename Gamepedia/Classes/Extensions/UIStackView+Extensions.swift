//
//  UIStackView+Extensions.swift
//  Gamepedia
//
//  Created by Dayton on 03/09/21.
//

import UIKit

extension UIStackView {
  private func remove(view: UIView) {
    removeArrangedSubview(view)
    view.removeFromSuperview()
  }

  func refresh() {
    self.arrangedSubviews.forEach { (view) in
      remove(view: view)
    }
  }
}
