//
//  EmptyView.swift
//  Gamepedia
//
//  Created by Dayton on 24/08/21.
//

import UIKit

protocol EmptyViewDelegate: AnyObject {
  func didTapButtonAction()
}

class EmptyView: UIView {

  @IBOutlet var contentView: UIView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var msgLabel: UILabel!
  @IBOutlet weak var reloadButton: UIButton!

  weak var delegate: EmptyViewDelegate?

  override init(frame: CGRect) {
    super.init(frame: frame)
    xibSetup()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    xibSetup()
  }

  @IBAction func didTapButton(_ sender: UIButton) {
    self.delegate?.didTapButtonAction()
  }
}

// MARK: - Set Components
extension EmptyView {
  func xibSetup() {
    contentView = loadNib()
    contentView.frame = bounds
    contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    addSubview(contentView)
  }
}
