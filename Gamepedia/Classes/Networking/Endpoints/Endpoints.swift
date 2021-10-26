//
//  Endpoints.swift
//  Gamepedia
//
//  Created by Dayton on 24/08/21.
//

import Foundation

enum Endpoints: APIConfig {
  case gameList
  case gameDetail(_ id: Int)
  case search(_ query: String)

  var path: String {
    switch self {
    case .gameList, .search(_):
      return "games"
    case .gameDetail(let id):
      return "games/\(id)"
    }
  }

  var baseURL: URL {
    guard let initialURL = URL(string: Environment.baseURL) else { fatalError("Failed Init URL")}
    let baseURL = initialURL.appendingPathComponent(path)
    return baseURL
  }

  var components: URLComponents {
    guard var components =  URLComponents(url: baseURL, resolvingAgainstBaseURL: true) else {
      fatalError("Couldn't create URLComponents")
    }
    components.queryItems = [URLQueryItem(name: "key", value: Environment.apiKey)]

    switch self {
    case .gameList, .gameDetail(_):
      components.queryItems = [URLQueryItem(name: "key", value: Environment.apiKey)]
    case .search(let query):
      components.queryItems = [
        URLQueryItem(name: "search", value: query),
        URLQueryItem(name: "key", value: Environment.apiKey)
      ]
    }

    return components
  }

  var urlRequest: URLRequest {
    guard let url = components.url else { fatalError("Component's URL Not Found")}
    let request = URLRequest(url: url)

    return request
  }
}
