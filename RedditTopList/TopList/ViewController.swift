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

  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    viewModel.handlePagination(itemsCount: items.count,
                               currentRow: indexPath.row) { [weak self] list in
      DispatchQueue.main.async {
        self?.onPaginate(list)
      }
    }
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 200
  }

  func onPaginate(_ newItems: [TopListElement]) {
    let newRows = IndexPath.createRows(newItems.count, startingAt: items.count)
    topListView.tableView.beginUpdates()
    items.append(contentsOf: newItems)
    topListView.tableView.insertRows(at: newRows, with: .top)
    topListView.tableView.endUpdates()
  }

  @objc func loadData() {
    viewModel.load {
      self.items = $0
      print($0)
      DispatchQueue.main.async {
        self.topListView.reload()
      }
    }
  }

  private func setupUI() {
    topListView.inflate(with: view.frame)
    view = topListView
    topListView.refreshControl.addTarget(self, action: #selector(loadData), for: .valueChanged)
    topListView.setDelegate(self)
    topListView.registerCell(TopListCell.self,
                             identifier: TopListCell.identifier)
  }
}

