//
//  TopListRepositoryType.swift
//  RedditTopList
//
//  Created by Lucas Pedrazoli on 21/06/21.
//

import Foundation

protocol TopListRepositoryType {

  func getList(_ completion: @escaping (TopList?) -> Void)
  func paginate(lastItemId: String, itemsCount: Int, _ completion: @escaping (TopList?) -> Void)
}
