//
//  UserDataCoordinator.swift
//  Gamepedia
//
//  Created by Dayton on 03/09/21.
//

import RxSwift

class UserDataCoordinator: ReactiveCoordinator<Void> {

  private let rootViewController: UIViewController
  private let viewModel = UserDataViewModel()

  init(rootViewController: UIViewController) {
    self.rootViewController = rootViewController
  }

  override func start() -> Observable<Void> {
    let viewController = UserDataView()
    viewController.viewModel = viewModel
    viewController.hidesBottomBarWhenPushed = true
    rootViewController.navigationController?.pushViewController(viewController, animated: true)

    return Observable.never()
  }
}
