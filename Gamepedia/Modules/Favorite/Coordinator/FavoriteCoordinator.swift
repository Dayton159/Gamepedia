//
//  FavoriteCoordinator.swift
//  Gamepedia
//
//  Created by Dayton on 03/09/21.
//

import RxSwift

class FavoriteCoordinator: ReactiveCoordinator<Void> {

  let rootViewController: UIViewController
  private let viewModel = FavoriteViewModel()

  init(rootViewController: UIViewController) {
    self.rootViewController = rootViewController
  }

  override func start() -> Observable<Void> {
    guard let viewController = rootViewController as? FavoriteView
    else { fatalError("Cannot Cast View Controller")}

    viewController.viewModel = viewModel

    self.viewModel
      .didSelectGame
      .flatMapLatest({[weak self] game -> Observable<Void> in
        guard let self = self else { return Observable.never()}
        return self.coordinateToGameDetail(game)
      }).subscribe()
      .disposed(by: disposeBag)

    return Observable.never()
  }

  private func coordinateToGameDetail(_ game: GameResult) -> Observable<Void> {
    let gameDetailCoordinator = GameDetailCoordinator(
      rootViewController: rootViewController,
      game: game,
      request: .local)
    return coordinate(to: gameDetailCoordinator)
  }
}
