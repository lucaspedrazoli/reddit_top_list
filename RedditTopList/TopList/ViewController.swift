//
//  ViewController.swift
//  RedditTopList
//
//  Created by Lucas Pedrazoli on 21/06/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ReloadCellDelegate {

  var continuationActivity: NSUserActivity {
    let activity = NSUserActivity(activityType: "com.myapp.restoration")
    activity.persistentIdentifier = UUID().uuidString
    activity.title = "restoration"
    activity.addUserInfoEntries(from: ["list_clear": listClearPressed])
    return activity
  }

  var viewModel: TopListViewModel!
  var topListView: TopListView!
  var items: [TopListElement] = []
  weak var splitControllerDelegate: SplitControllerlegate?
  private var listClearPressed = false

  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    loadData()
  }

  func continueFrom(activity: NSUserActivity) {
    listClearPressed = activity.userInfo?["list_clear"] as? Bool ?? false
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return items.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let item = items[indexPath.row]
    guard let cell = TopListCell.dequeue(for: topListView.tableView, at: indexPath, from: item) else { return UITableViewCell() }
    cell.reloadDelegate = self
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

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let item = items[indexPath.row]
    splitControllerDelegate?.showDetailItem(item)
  }

  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      items.remove(at: indexPath.row)
      topListView.deleteCell(at: indexPath)
    }
  }

  func onPaginate(_ newItems: [TopListElement]) {
    let newRows = IndexPath.createRows(newItems.count, startingAt: items.count)
    topListView.tableView.beginUpdates()
    items.append(contentsOf: newItems)
    topListView.tableView.insertRows(at: newRows, with: .top)
    topListView.tableView.endUpdates()
  }

  func reloadCell(at indexPath: IndexPath) {
    items[indexPath.row].read = true
    topListView.reloadCell(at: indexPath)
    splitControllerDelegate?.showDetailItem(items[indexPath.row])
  }

  @objc func loadData() {
    viewModel.load { [weak self] list in
      guard let self = self else { return }
      self.items = list
      DispatchQueue.main.async {
        self.splitControllerDelegate?.showDetailItem(list.first)
        self.topListView.reload()
      }
    }
  }

  @objc func clear() {
    let count = items.count
    items.removeAll()
    topListView.clear(itemsCount: count)
    listClearPressed = true
  }

  private func setupUI() {
    topListView.inflate(with: view.frame)
    view = topListView
    topListView.refreshControl.addTarget(self, action: #selector(loadData), for: .valueChanged)
    topListView.setDelegate(self)
    topListView.registerCell(TopListCell.self,
                             identifier: TopListCell.identifier)
    navigationItem
      .rightBarButtonItem = UIBarButtonItem(title: "Clear",
                                           style: .plain,
                                           target: self,
                                           action: #selector(clear))
  }
}

