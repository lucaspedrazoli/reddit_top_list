//
//  ViewController.swift
//  RedditTopList
//
//  Created by Lucas Pedrazoli on 21/06/21.
//

import UIKit

class ViewController: UIViewController {

  var viewModel: TopListViewModel!

  override func viewDidLoad() {
    super.viewDidLoad()
    viewModel.load {
      print($0.first?.title ?? "")
    }
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    view.backgroundColor = .yellow
  }
}

