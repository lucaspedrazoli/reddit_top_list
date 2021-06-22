//
//  ViewController.swift
//  RedditTopList
//
//  Created by Lucas Pedrazoli on 21/06/21.
//

import UIKit

class ViewController: UIViewController {

  var viewModel: TopListViewModel!
  var topListView: TopListView!

  override func viewDidLoad() {
    super.viewDidLoad()
    topListView.inflate(with: view.frame)
    view = topListView
    viewModel.load {
      print($0.first?.title ?? "")
    }
  }
}

