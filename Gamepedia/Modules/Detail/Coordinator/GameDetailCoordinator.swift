//
//  GameDetailCoordinator.swift
//  Gamepedia
//
//  Created by Dayton on 26/08/21.
//

import RxSwift

class GameDetailCoordinator: ReactiveCoordinator<Void> {

  private let rootViewController: UIViewController
  private let viewModel = GameDetailViewModel()

  init(rootViewController: UIViewController, game: GameResult, request: DataRequestSource = .network) {
    self.rootViewController = rootViewController
    self.viewModel.game = game
    self.viewModel.request = request
  }

  override func start() -> Observable<Void> {
    let viewController = GameDetailView()
    viewController.viewModel = viewModel

    viewController.hidesBottomBarWhenPushed = true
    rootViewController.navigationController?.pushViewController(viewController, animated: true)

    return Observable.never()
  }
}
