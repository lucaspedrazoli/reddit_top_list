//
//  TopListElement.swift
//  RedditTopList
//
//  Created by Lucas Pedrazoli on 21/06/21.
//

import Foundation

struct TopListElement: Codable {
  let title: String
  let author: String
  let thumbnail: String
  let created: Double
  let created_utc: Double
  let num_comments: Int
  let clicked: Bool
  let visited: Bool
}

