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
    let label = UILabel(frame: CGRect(x: 300, y: 200, width: 200, height: 200))
    label.text = "aaassasasasggfsdgfgd"
    label.numberOfLines = 0
    label.textAlignment = .center
    //label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    view.addSubview(titleLabel)
    view.backgroundColor = .yellow
  }

  func showDetailItem(_ item: TopListElement?) {
    guard let item = item else { return }
    titleLabel.text = item.title
  }

}
