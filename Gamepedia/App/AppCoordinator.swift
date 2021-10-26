//
//  AppCoordinator.swift
//  Gamepedia
//
//  Created by Dayton on 24/08/21.
//

import RxSwift

class AppCoordinator: ReactiveCoordinator<Void> {

  var window: UIWindow

  init(window: UIWindow) {
    self.window = window
  }

  override func start() -> Observable<Void> {

    let initialVC = MainView()
    let mainTabViewCoordinator = MainViewCoordinator(rootViewController: initialVC)

    window.rootViewController = initialVC
    window.makeKeyAndVisible()

    UIView.transition(with: window,
                      duration: 0.5,
                      options: .transitionCrossDissolve,
                      animations: nil,
                      completion: nil)

    return coordinate(to: mainTabViewCoordinator)
  }
}
