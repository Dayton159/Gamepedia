//
//  InputContainerView.swift
//  Gamepedia
//
//  Created by Dayton on 03/09/21.
//

import RxSwift

@IBDesignable
class InputContainerView: UIView {
  // MARK: - Properties
  @IBOutlet weak var contentView: UIView!
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var textField: UITextField! {
    didSet {
      self.textField.keyboardAppearance = .dark
    }
  }

  private let disposeBag = DisposeBag()
  public let textFieldObservable = PublishSubject<String>()

  // MARK: - Initializers
  override init(frame: CGRect) {
    super.init(frame: frame)
    xibSetup()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    xibSetup()
  }

}

  // MARK: - Extensions
extension InputContainerView {
  func xibSetup() {
    contentView = loadNib()
    contentView.frame = bounds
    contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    addSubview(contentView)

    self.textField.rx
      .controlEvent(.allEditingEvents)
      .withLatestFrom(self.textField.rx.text.orEmpty)
      .asObservable()
      .subscribe(onNext: { [weak self] input in
        guard let self = self else { return }
        self.textFieldObservable.onNext(input)
      }).disposed(by: disposeBag)
  }
}

extension InputContainerView {
  @IBInspectable var image: UIImage? {
    get { return imageView.image }
    set { self.imageView.image = newValue }
  }

  @IBInspectable var placeholder: String? {
    get { return textField.placeholder }
    set { self.textField.attributedPlaceholder = NSAttributedString(
      string: newValue ?? "",
      attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightText])
    }
  }
}
