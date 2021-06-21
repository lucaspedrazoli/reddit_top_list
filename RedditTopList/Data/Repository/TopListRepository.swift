//
//  TopListRepository.swift
//  RedditTopList
//
//  Created by Lucas Pedrazoli on 21/06/21.
//

import Foundation

struct TopListRepository {
  let network: NetworkDataSourceType
  let userSession: UserSessionDataSourceType
  

  init(network: NetworkDataSourceType,
       userSession: UserSessionDataSourceType) {
    self.network = network
    self.userSession = userSession
  }

  func getList(_ completion: (TopList) -> Void) {

  }
}
