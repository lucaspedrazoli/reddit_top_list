//
//  Endpoint.swift
//  RedditTopList
//
//  Created by Lucas Pedrazoli on 21/06/21.
//

import Foundation

enum Endpoint {
  case topList
  case refreshToken
}

extension Endpoint {

  var entrypoint: String {
      return "https://www.reddit.com"
    }

  var oauthEntrypoint: String {
    return "https://oauth.reddit.com"
  }

  var rawValue: URL {
      switch self {
      case .refreshToken:
        return URL(string: "\(entrypoint)/api/v1/access_token")!
      case .topList:
        return URL(string: "\(oauthEntrypoint)/top")!
      }
  }
}
