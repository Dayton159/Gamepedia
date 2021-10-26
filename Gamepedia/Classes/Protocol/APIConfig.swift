//
//  APIConfig.swift
//  Gamepedia
//
//  Created by Dayton on 24/08/21.
//

import Foundation

protocol APIConfig {
  var path: String { get }
  var baseURL: URL { get }
  var components: URLComponents { get }
  var urlRequest: URLRequest { get }
}
