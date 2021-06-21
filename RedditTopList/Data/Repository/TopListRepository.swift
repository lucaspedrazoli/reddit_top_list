//
//  TopListRepository.swift
//  RedditTopList
//
//  Created by Lucas Pedrazoli on 21/06/21.
//

import Foundation

class TopListRepository: TopListRepositoryType {
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

  func getList(_ completion: @escaping (TopList?) -> Void) {
    var request = requestFactory.createTopList()
    let token: String? = userSession.read(for: .accessToken)
    request.addBearerToken(token)
    network.doRequest(request, completion: { (model: TopList?) in
      completion(model)
    })
  }
}
