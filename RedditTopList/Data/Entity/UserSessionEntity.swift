//
//  UserSessionEntity.swift
//  RedditTopList
//
//  Created by Lucas Pedrazoli on 21/06/21.
//

import Foundation

struct UserSessionEntity: Codable {
  let access_token: String
  let refresh_token: String
}
