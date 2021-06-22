//
//  DependencyContainer.swift
//  RedditTopList
//
//  Created by Lucas Pedrazoli on 22/06/21.
//

import Foundation

struct DependencyContainer {
  let networkDataSource = NetworkDataSource()
  let userSessionDataSource = UserSessionDataSource()
  let requestFactory = RequestFactory()

  func makeTopListViewModel() -> TopListViewModel {
    let topListRepository = TopListRepository(network: networkDataSource,
                                              userSession: userSessionDataSource,
                                              requestFactory: requestFactory)
    return TopListViewModel(topListRepository: topListRepository)
  }
}
