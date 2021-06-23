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
  let createdAt: Double
  let commentsCount: Int
  let url: String
  var read: Bool

  enum CodingKeys: String, CodingKey {
    case title, author, thumbnail, url
    case commentsCount = "num_comments"
    case createdAt = "created_utc"
  }

  init(from decoder: Decoder) throws {
    let data = try decoder.container(keyedBy: CodingKeys.self)
    title = try data.decode(String.self, forKey: .title)
    author = try data.decode(String.self, forKey: .author)
    thumbnail = try data.decode(String.self, forKey: .thumbnail)
    createdAt = try data.decode(Double.self, forKey: .createdAt)
    commentsCount = try data.decode(Int.self, forKey: .commentsCount)
    url = try data.decode(String.self, forKey: .url)
    read = false
  }
}

