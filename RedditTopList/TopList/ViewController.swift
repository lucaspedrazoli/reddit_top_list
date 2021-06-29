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
    activity.addUserInfoEntries(from: ["Count":self.count])
    return activity
  }

  func continueFrom(activity: NSUserActivity) {
    let count = activity.userInfo?["Count"] as? Int ?? 0
    self.count = count
  }

  var viewModel: TopListViewModel!
  var topListView: TopListView!
  var items: [TopListElement] = []
  weak var splitControllerDelegate: SplitControllerlegate?
  var count = 100
  let label = UILabel(frame: CGRect(x: 100, y: 100, width: 200, height: 200))

  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    loadData()
    view.addSubview(label)
    label.text = "LOAD COUNT \(self.count)"
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
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

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableView.automaticDimension
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
    self.count += 1
    label.text = "COUNT: \(self.count)"
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

