//
//  DetailRepository.swift
//  Gamepedia
//
//  Created by Dayton on 27/08/21.
//

import RxSwift

class DetailRepository {
  func getDetail(_ id: Int) -> Single<Result<GameDetailModel, ErrorModel>> {
    return APIService.request(endPoint: Endpoints.gameDetail(id))
  }
}
