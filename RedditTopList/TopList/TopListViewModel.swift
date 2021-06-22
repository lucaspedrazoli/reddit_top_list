//
//  TopListViewModel.swift
//  RedditTopList
//
//  Created by Lucas Pedrazoli on 22/06/21.
//

import Foundation

class TopListViewModel {

  let topListRepository: TopListRepositoryType

  init(topListRepository: TopListRepositoryType) {
    self.topListRepository = topListRepository
  }

  func load(_ completion: @escaping (TopList?) -> Void) {
    topListRepository.getList {
      completion($0)
    }
  }
}
