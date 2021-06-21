//
//  NetworkDataSourceType.swift
//  RedditTopList
//
//  Created by Lucas Pedrazoli on 21/06/21.
//

import Foundation

protocol NetworkDataSourceType {
  associatedtype T: Codable

  func doRequest(_ request: Request, completion: @escaping (_ model: T?) -> Void)
}
