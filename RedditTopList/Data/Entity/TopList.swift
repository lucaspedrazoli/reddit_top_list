//
//  TopList.swift
//  RedditTopList
//
//  Created by Lucas Pedrazoli on 21/06/21.
//

import Foundation

struct TopList: Codable {
  let data: ListData
}

extension TopList {
  struct ListData: Codable {
    let children: [ListElementData]
    let after: String
  }

  struct ListElementData: Codable {
    let data: TopListElement
  }
}
