//
//  IndexPath.swift
//  RedditTopList
//
//  Created by Lucas Pedrazoli on 22/06/21.
//

import UIKit

extension IndexPath {

  static func createRows(_ rows: Int, startingAt position: Int) -> [IndexPath] {
    var indexPaths = [IndexPath]()
    let limit = rows + position
    for count in position ..< limit {
      let indexPath = IndexPath(row: count, section: 0)
      indexPaths.append(indexPath)
    }
    return indexPaths
  }
}
