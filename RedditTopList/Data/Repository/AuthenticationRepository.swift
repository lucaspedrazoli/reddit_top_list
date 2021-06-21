//
//  AuthenticationRepository.swift
//  RedditTopList
//
//  Created by Lucas Pedrazoli on 21/06/21.
//

import Foundation

struct AuthenticationRepository: AuthenticationRepositoryType {
  let network: NetworkDataSourceType
  let userSession: UserSessionDataSourceType
  var requestFactory: RequestFactory

  init(network: NetworkDataSourceType,
       userSession: UserSessionDataSourceType,
       requestFactory: RequestFactory) {
    self.network = network
    self.userSession = userSession
    self.requestFactory = requestFactory
  }

  func refreshToken() {

  }
}
