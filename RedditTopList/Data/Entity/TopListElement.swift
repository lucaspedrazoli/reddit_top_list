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
  let postHint: String
  var read: Bool

  enum CodingKeys: String, CodingKey {
    case title, author, thumbnail, url
    case commentsCount = "num_comments"
    case createdAt = "created_utc"
    case postHint = "post_hint"
  }

  static func empty() -> TopListElement {
    let timestamp = Date().timeIntervalSince1970
    return TopListElement(title: "title",
                          author: "author",
                          thumbnail: "thumb",
                          createdAt: timestamp,
                          commentsCount: 0,
                          url: "url",
                          postHint: "post_hint")
  }

  init(title: String,
       author: String,
       thumbnail: String,
       createdAt: Double,
       commentsCount: Int,
       url: String,
       postHint: String,
       read: Bool = false) {
    self.title = title
    self.author = author
    self.thumbnail = thumbnail
    self.createdAt = createdAt
    self.commentsCount = commentsCount
    self.url = url
    self.postHint = postHint
    self.read = read
  }

  init(from decoder: Decoder) throws {
    let data = try decoder.container(keyedBy: CodingKeys.self)
    title = try data.decode(String.self, forKey: .title)
    author = try data.decode(String.self, forKey: .author)
    thumbnail = try data.decode(String.self, forKey: .thumbnail)
    createdAt = try data.decode(Double.self, forKey: .createdAt)
    commentsCount = try data.decode(Int.self, forKey: .commentsCount)
    url = try data.decode(String.self, forKey: .url)
    postHint = try data.decode(String.self, forKey: .postHint)
    read = false
  }

  func status() -> String {
    read == true ? "read" : "unread"
  }

  func isImage() -> Bool {
    postHint == "image"
  }
}

