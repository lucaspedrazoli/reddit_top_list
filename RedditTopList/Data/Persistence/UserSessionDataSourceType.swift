//
//  UserSessionDataSourceType.swift
//  RedditTopList
//
//  Created by Lucas Pedrazoli on 21/06/21.
//

import Foundation

protocol UserSessionDataSourceType {

  func read<T>(for key: String) -> T?
  func write<T>(_ value: T, for key: String)
}
