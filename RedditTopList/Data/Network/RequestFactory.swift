//
//  RequestFactory.swift
//  RedditTopList
//
//  Created by Lucas Pedrazoli on 21/06/21.
//

import Foundation

struct RequestFactory {

  func createTopList() -> Request {
    return Request(endpoint: .topList, method: .GET)
  }

  func createRefreshToken() -> Request {
    var request = Request(endpoint: .refreshToken, method: .POST)
    request.addQueryItem(.grantType, value: "refresh_token")
    return request
  }

  func createPaginateTopList() -> Request {
    var request = Request(endpoint: .topList, method: .GET)
    request.addQueryItem(.limit, value: "10")
    return request
  }
}
