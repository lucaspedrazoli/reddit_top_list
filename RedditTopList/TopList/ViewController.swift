//
//  ViewController.swift
//  RedditTopList
//
//  Created by Lucas Pedrazoli on 21/06/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

  var viewModel: TopListViewModel!
  var topListView: TopListView!
  var items: [TopListElement] = []

  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return items.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    return UITableViewCell()
  }

  private func loadData() {
    viewModel.load {
      self.items = $0
      self.topListView.tableView.reloadData()
    }
  }

  private func setupUI() {
    topListView.inflate(with: view.frame)
    view = topListView
    topListView.registerCell(TopListCell.self,
                             identifier: TopListCell.identifier)
  }
}

