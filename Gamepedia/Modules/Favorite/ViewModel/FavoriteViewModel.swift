//
//  FavoriteViewModel.swift
//  Gamepedia
//
//  Created by Dayton on 03/09/21.
//

import RxSwift
import RxCocoa

class FavoriteViewModel: BaseViewModel {
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

  func getFavoriteGames() {
    self.state.onNext(.loading)
    CoreDataHelper.getAllFavoriteList { [weak self] result in
      guard let self = self else { return }
      switch result {
      case .success(let model):
        self.gameList.accept(model)
        self.state.onNext(.finish)
      case .failure(let error):
        self.state.onNext(.error)
        self.error.onNext(ErrorModel.setErrorMessage(error: error))
      }
    }
  }
}
