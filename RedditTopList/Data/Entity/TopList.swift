//
//  TopList.swift
//  RedditTopList
//
//  Created by Lucas Pedrazoli on 21/06/21.
//

import Foundation

struct TopList: Codable {
  private let data: ListData
}

private extension TopList {
  struct ListData: Codable {
    let children: [ListElementData]
  }

  struct ListElementData: Codable {
    let data: TopListElement
  }
}
