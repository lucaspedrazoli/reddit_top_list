//
//  UserSessionDataSource.swift
//  RedditTopList
//
//  Created by Lucas Pedrazoli on 21/06/21.
//

import Foundation

struct UserSessionDataSource: UserSessionDataSourceType {

  let userDefaults: UserDefaults

  init(userDefaults: UserDefaults = UserDefaults.standard) {
    self.userDefaults = userDefaults
  }

  func read<T>(for key: UserSessionKey) -> T? {
    let value = UserDefaults.standard.object(forKey: key.rawValue)
    return value as? T
  }

  func write<T>(_ value: T, for key: UserSessionKey) {
    let value = value as Any
    UserDefaults.standard.set(value, forKey: key.rawValue)
  }
}
