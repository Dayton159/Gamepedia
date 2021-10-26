//
//  HomeCoordinator.swift
//  Gamepedia
//
//  Created by Dayton on 24/08/21.
//

import RxSwift

class HomeCoordinator: ReactiveCoordinator<Void> {

  let rootViewController: UIViewController
  private let viewModel = HomeViewModel()

  init(rootViewController: UIViewController) {
    self.rootViewController = rootViewController
  }

  override func start() -> Observable<Void> {
    guard let viewController = rootViewController as? HomeView
    else { fatalError("Cannot Cast ViewController")}

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
      game: game)
    return coordinate(to: gameDetailCoordinator)
  }
}
