//
//  DetailViewController.swift
//  RedditTopList
//
//  Created by Lucas Pedrazoli on 23/06/21.
//

import Foundation
import UIKit

class DetailViewController: NiblessViewController, SplitControllerlegate {

  var item: TopListElement?

  lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    label.textAlignment = .center
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    view.addSubview(titleLabel)
  }

  func showDetailItem(_ item: TopListElement) {
    titleLabel.text = item.title
  }

}
