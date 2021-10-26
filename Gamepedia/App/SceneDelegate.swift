//
//  SceneDelegate.swift
//  Gamepedia
//
//  Created by Dayton on 24/08/21.
//

import RxSwift

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?
  private var appCoordinator: AppCoordinator!
  private let disposeBag = DisposeBag()

  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = (scene as? UIWindowScene) else { return }

    window = UIWindow(frame: windowScene.coordinateSpace.bounds)
    window?.windowScene = windowScene

    appCoordinator = AppCoordinator(window: window!)
    appCoordinator.start()
      .subscribe()
      .disposed(by: disposeBag)
  }

  func sceneDidDisconnect(_ scene: UIScene) {

  }

  func sceneDidBecomeActive(_ scene: UIScene) {

  }

  func sceneWillResignActive(_ scene: UIScene) {

  }

  func sceneWillEnterForeground(_ scene: UIScene) {

  }

  func sceneDidEnterBackground(_ scene: UIScene) {

  }
}
