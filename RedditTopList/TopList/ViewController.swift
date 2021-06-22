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
    loadData()
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return items.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let item = items[indexPath.row]
    let cell = TopListCell.dequeue(for: topListView.tableView, at: indexPath, from: item)
    return cell
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 200
  }

  private func loadData() {
    viewModel.load {
      self.items = $0
      print($0)
      DispatchQueue.main.async {
        self.topListView.tableView.reloadData()
      }
    }
  }

  private func setupUI() {
    topListView.inflate(with: view.frame)
    view = topListView
    topListView.tableView.delegate = self
    topListView.tableView.dataSource = self
    topListView.registerCell(TopListCell.self,
                             identifier: TopListCell.identifier)
  }
}

