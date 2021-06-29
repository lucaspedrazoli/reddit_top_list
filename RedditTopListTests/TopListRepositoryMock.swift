//
//  TopListRepositoryMock.swift
//  RedditTopListTests
//
//  Created by Lucas Pedrazoli on 29/06/21.
//

import Foundation
@testable import RedditTopList

struct TopListRepositoryMock: TopListRepositoryType {

  var topList: TopList?

  func getList(_ completion: @escaping (TopList?) -> Void) {
    completion(topList)
  }

  func paginate(lastItemId: String, itemsCount: Int, _ completion: @escaping (TopList?) -> Void) {
    completion(topList)
  }
}
