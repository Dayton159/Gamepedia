//
//  HomeViewModel.swift
//  Gamepedia
//
//  Created by Dayton on 25/08/21.
//

import RxSwift
import RxCocoa

class HomeViewModel: BaseViewModel {
  private let repository = HomeRepository()
  private(set) var gameList = BehaviorRelay<[GameResult]>(value: [])
  var didSelectGame = PublishSubject<GameResult>()

  var getNumberOfGame: Int {
    return gameList.value.count
  }

  func configureCell(_ cell: HomeTableViewCell, _ indexPath: IndexPath) {
    let gameData = self.getGameAt(indexPath)
    cell.configureCell(gameData)
  }

  func getGameAt(_ indexPath: IndexPath) -> GameResult {
    return self.gameList.value[indexPath.row]
  }

  func getGameList() {
    self.state.onNext(.loading)

    self.repository.getGame()
      .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
      .observe(on: MainScheduler.instance)
      .subscribe(onSuccess: { [weak self] result in
        guard let self = self else { return }
        switch result {
        case .success(let model):
          if let game = model.results {
            self.gameList.accept(game)
          }
        case .failure(let error):
          self.error.onNext(error)
        }
        self.state.onNext(.finish)
      }, onFailure: { [weak self] error in
        guard let self = self,
              let errorModel = error as? APIServiceError else { return }
        self.state.onNext(.error)
        self.error.onNext(ErrorModel.setErrorMessage(error: errorModel))
      }).disposed(by: disposeBag)
  }

  func searchForGame(with query: String) {
    self.state.onNext(.loading)

    self.repository.searchGame(query)
      .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
      .observe(on: MainScheduler.instance)
      .subscribe(onSuccess: { [weak self] result in
        guard let self = self else { return }
        switch result {
        case .success(let model):
          if let game = model.results {
            self.gameList.accept(game)
          }
        case .failure(let error):
          self.error.onNext(error)
        }
        self.state.onNext(.finish)
      }, onFailure: { [weak self] error in
        guard let self = self,
              let errorModel = error as? APIServiceError else { return }
        self.state.onNext(.error)
        self.error.onNext(ErrorModel.setErrorMessage(error: errorModel))
      }).disposed(by: disposeBag)
  }
}
