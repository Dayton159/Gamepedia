//
//  BaseViewModel.swift
//  Gamepedia
//
//  Created by Dayton on 24/08/21.
//

import RxSwift

enum NetworkState {
  case loading
  case finish
  case error
}

class BaseViewModel {
  let disposeBag  = DisposeBag()
  var state       = PublishSubject<NetworkState>()
  var error       = PublishSubject<ErrorModel>()
}
