//
//  APIService.swift
//  Gamepedia
//
//  Created by Dayton on 25/08/21.
//

import RxSwift

enum Result<Value, Error> {
  case success(Value)
  case failure(Error)

  init(value: Value) {
    self = .success(value)
  }

  init(error: Error) {
    self = .failure(error)
  }
}

class APIService {

  static func request<T: Codable>(endPoint: APIConfig) -> Single<Result<T, ErrorModel>> {

    return Single<Result<T, ErrorModel>>.create { single in
      let datatask =  URLSession.shared.dataTask(with: endPoint.urlRequest) { data, response, error in

        guard let httpResponse = response as? HTTPURLResponse else {
          single(.failure(APIServiceError.noInternetConnection))
          return
        }

        guard let data = data, error == nil else {
          single(.failure(APIServiceError.cannotMapToObject))
          return
        }

        if 200..<300 ~= httpResponse.statusCode {
          do {
            let model = try JSONDecoder().decode(T.self, from: data)
            single(.success(.success(model)))
          } catch let error {
            single(.failure(APIServiceError.custom(error)))
          }
        } else {
          do {
            let model = try JSONDecoder().decode(ErrorModel.self, from: data)
            single(.success(.failure(model)))
          } catch let error {
            single(.failure(APIServiceError.custom(error)))
          }
        }
      }

      datatask.resume()

      return Disposables.create {
        datatask.cancel()
      }
    }
  }
}
