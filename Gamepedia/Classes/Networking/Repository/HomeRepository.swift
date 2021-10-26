//
//  HomeRepository.swift
//  Gamepedia
//
//  Created by Dayton on 25/08/21.
//

import RxSwift

class HomeRepository {
  func getGame() -> Single<Result<GameModel, ErrorModel>> {
    return APIService.request(endPoint: Endpoints.gameList)
  }

  func searchGame(_ query: String) -> Single<Result<GameModel, ErrorModel>> {
    return APIService.request(endPoint: Endpoints.search(query))
  }
}
