//
//  EmptyViewBuilder.swift
//  Gamepedia
//
//  Created by Dayton on 24/08/21.
//

import UIKit

class EmptyViewBuilder {
  private var emptyView = EmptyView()

  @discardableResult
  func setEmpty(_ title: String?, _ msg: String?) -> EmptyViewBuilder {
    emptyView.titleLabel.text = title
    emptyView.msgLabel.text = msg
    return self
  }

  @discardableResult
  func setButtonTitle(_ buttonTitle: String?, delegate: EmptyViewDelegate?) -> EmptyViewBuilder {
    emptyView.reloadButton.isHidden = false
    emptyView.reloadButton.setTitle(buttonTitle, for: .normal)
    emptyView.delegate = delegate
    return self
  }

  func build() -> EmptyView {
    return emptyView
  }
}
