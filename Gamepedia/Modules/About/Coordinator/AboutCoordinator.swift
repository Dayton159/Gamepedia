//
//  AboutCoordinator.swift
//  Gamepedia
//
//  Created by Dayton on 24/08/21.
//

import RxSwift

class AboutCoordinator: ReactiveCoordinator<Void> {

  let rootViewController: UIViewController
  private var viewModel = AboutViewModel()

  init(rootViewController: UIViewController) {
    self.rootViewController = rootViewController
  }

  override func start() -> Observable<Void> {
    guard let viewController = rootViewController as? AboutView
    else { fatalError("Cannot Cast ViewController")}
    viewController.viewModel = viewModel

    self.viewModel
      .didTapEdit
      .flatMapLatest({[weak self] _ -> Observable<Void> in
        guard let self = self else { return Observable.never()}
        return self.coordinateToUserData()
      }).subscribe()
      .disposed(by: disposeBag)

    return Observable.never()
  }

  private func coordinateToUserData() -> Observable<Void> {
    let gameDetailCoordinator = UserDataCoordinator(
      rootViewController: rootViewController)
    return coordinate(to: gameDetailCoordinator)
  }
}
