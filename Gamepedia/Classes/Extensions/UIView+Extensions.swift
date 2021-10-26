//
//  UIView+Extensions.swift
//  Gamepedia
//
//  Created by Dayton on 24/08/21.
//

import UIKit

extension UIView {

  func loadNib() -> UIView {
    let bundle = Bundle(for: type(of: self))
    let nib = UINib(nibName: String(describing: self.classForCoder), bundle: bundle)
    guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else { fatalError("Can't load Nib") }
    return view
  }

  @IBInspectable var borderColor: UIColor? {
    get { return layer.borderColor.map(UIColor.init) }
    set { layer.borderColor = newValue?.cgColor }
  }
  @IBInspectable var borderWidth: CGFloat {
    get { return layer.borderWidth }
    set { layer.borderWidth = newValue }
  }

  @IBInspectable var cornerRadius: CGFloat {
    get { return layer.cornerRadius }
    set { layer.cornerRadius = newValue }
  }
}
