//
//  BaseView.swift
//  Gamepedia
//
//  Created by Dayton on 24/08/21.
//

import RxSwift
import JGProgressHUD

open class BaseView: UIViewController {
  static let darkHud = JGProgressHUD(style: .dark)
  public var disposeBag = DisposeBag()
  public var barButton = PublishSubject<Void>()
  public var favoriteBarBtn = PublishSubject<Bool>()

  private var isFavorited: Bool?
  private var barBtnType: BarButtonType?

  private lazy var rightButtonItem: UIButton = {
    let button = UIButton()
    button.tintColor = .white
    button.addTarget(self, action: #selector(self.didTapRightBarBtn(_:)), for: .touchUpInside)
    return button
  }()

  func configureNavBar(withTitle title: String? = nil, prefersLargeTitles: Bool = false) {
    let appearance = UINavigationBarAppearance()
    appearance.configureWithOpaqueBackground()
    appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white, .font: Constants.Font.bold(34)]
    appearance.titleTextAttributes = [.foregroundColor: UIColor.white, .font: Constants.Font.regular(18)]
    appearance.backgroundColor = Constants.Color.navigation

    navigationController?.navigationBar.standardAppearance = appearance
    navigationController?.navigationBar.compactAppearance = appearance
    navigationController?.navigationBar.scrollEdgeAppearance = appearance

    navigationController?.navigationBar.prefersLargeTitles = prefersLargeTitles
    navigationItem.title = title

    navigationController?.navigationBar.tintColor = .white
    navigationController?.navigationBar.isTranslucent = true

    navigationController?.navigationBar.overrideUserInterfaceStyle = .dark
    self.navigationController?.navigationBar.barStyle = .black
  }

  func showLoader(withText text: String? = "Loading") {
    BaseView.darkHud.textLabel.text = text
    BaseView.darkHud.show(in: view)
  }

  func hideLoader() {
    BaseView.darkHud.dismiss()
  }

  @objc func didTapRightBarBtn(_ sender: UIButton) {
    guard let type = barBtnType else { return }
    switch type {
    case .defaultAction:
      barButton.onNext(())
    case .toogle:
      guard let favState = self.isFavorited else { return }
      favoriteBarBtn.onNext(!favState)
    }
  }

  func configureRightBarButtonItem(with image: UIImage?, type: BarButtonType = .defaultAction) {
    let barItem = UIBarButtonItem(customView: rightButtonItem)
    self.changeBarBtnImage(image)
    self.enableBarBtn(enable: false)
    self.barBtnType = type
    navigationItem.rightBarButtonItems = [barItem]
  }

  func enableBarBtn(enable: Bool = true) {
    self.rightButtonItem.isUserInteractionEnabled = enable
    self.rightButtonItem.isEnabled = enable
  }

  private func changeBarBtnImage(_ image: UIImage?) {
    self.rightButtonItem.setImage(image, for: .normal)
  }

  func changeFavBtnState(isFav: Bool) {
    self.isFavorited = isFav
    self.changeBarBtnImage(isFav ? Constants.Image.bookmarkFill : Constants.Image.bookmark)
  }
}

enum BarButtonType {
  case toogle
  case defaultAction
}

enum DataRequestSource {
  case network
  case local
}
