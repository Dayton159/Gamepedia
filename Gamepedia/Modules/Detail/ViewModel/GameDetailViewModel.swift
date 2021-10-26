//
//  GameDetailViewModel.swift
//  Gamepedia
//
//  Created by Dayton on 26/08/21.
//

import RxSwift
import RxCocoa

class GameDetailViewModel: BaseViewModel {
  private let repository = DetailRepository()
  private(set) var gameDetail = BehaviorRelay<GameDetail?>(value: nil)
  private(set) var isFavorite = PublishSubject<Bool>()
  var game: GameResult?
  var request: DataRequestSource?

  func configureGeneralCell(_ cell: GeneralTableViewCell, _ indexPath: IndexPath) {
    guard let data = gameDetail.value else { return }
    cell.configureGeneral(with: data.general)
  }

  func configureDetailCell(_ cell: DetailTableViewCell, _ indexPath: IndexPath) {
    guard let data = gameDetail.value else { return }
    cell.configureDetail(with: data.detail)
  }

  func getGameDetail() {
    self.state.onNext(.loading)

    guard let id = game?.idGame else {
      self.state.onNext(.error)
      return
    }

    self.repository.getDetail(id)
      .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
      .observe(on: MainScheduler.instance)
      .subscribe(onSuccess: { [weak self] result in
        guard let self = self else { return }
        switch result {
        case .success(let detail):
          if let general = self.game {
            self.gameDetail.accept(GameDetail.init(general, detail))
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

  func saveGameToFavorite() {
    self.state.onNext(.loading)
    guard let data = gameDetail.value else { return }
    CoreDataHelper.saveFavoriteGame(game: data) { result in
      switch result {
      case .success(_):
        self.isFavorite.onNext(true)
        self.state.onNext(.finish)
      case .failure(let error):
        self.state.onNext(.error)
        self.error.onNext(ErrorModel.setErrorMessage(error: error))
      }
    }
  }

  func deleteGameFromFavorite() {
    self.state.onNext(.loading)
    guard let id = game?.idGame else { return }
    CoreDataHelper.deleteFavoriteGame(id) { result in
      switch result {
      case .success(_):
        self.isFavorite.onNext(false)
        self.state.onNext(.finish)
      case .failure(let error):
        self.state.onNext(.error)
        self.error.onNext(ErrorModel.setErrorMessage(error: error))
      }
    }
  }

  func isMarkedFavorite() {
    guard let id = game?.idGame else { return }
    CoreDataHelper.isFavorited(id: id) { result in
      switch result {
      case .success(let state):
        self.isFavorite.onNext(state)
      case .failure(let error):
        self.error.onNext(ErrorModel.setErrorMessage(error: error))
      }
    }
  }

  func getDetailFromCoreData() {
    self.state.onNext(.loading)
    guard let id = game?.idGame else { return }
    CoreDataHelper.getFavoriteGame(id) { result in
      switch result {
      case.success(let model):
        self.gameDetail.accept(model)
        self.state.onNext(.finish)
      case .failure(let error):
        self.state.onNext(.error)
        self.error.onNext(ErrorModel.setErrorMessage(error: error))
      }
    }
  }
}
