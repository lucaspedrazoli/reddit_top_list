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
    let grantType = URLQueryItem(name: QueryKey.grantType.rawValue, value: "refresh_token")
    request.addQueryItem(grantType)
    return request
  }
}
