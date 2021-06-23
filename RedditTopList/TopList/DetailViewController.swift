//
//  DetailViewController.swift
//  RedditTopList
//
//  Created by Lucas Pedrazoli on 23/06/21.
//

import Foundation
import UIKit

class DetailViewController: NiblessViewController {

  let delegate: SplitDataSourceDelegate

  init(delegate: SplitDataSourceDelegate) {
    self.delegate = delegate
    super.init()
  }

  func run() {
    delegate.didSelectItem { (item: TopListElement) in
      print(item)
    }
  }
}
