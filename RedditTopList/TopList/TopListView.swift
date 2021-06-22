//
//  TopListView.swift
//  RedditTopList
//
//  Created by Lucas Pedrazoli on 22/06/21.
//

import Foundation
import UIKit

class TopListView: NiblessView {

  lazy var container: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = .white
    return view
  }()

  lazy var refreshControl: UIRefreshControl = {
    let spinner = UIRefreshControl()
    spinner.attributedTitle = NSAttributedString(string: "Pull to refresh")
    return spinner
  }()

  lazy var tableView: UITableView = {
    let tableView = UITableView()
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.backgroundColor = .clear
    tableView.rowHeight = UITableView.automaticDimension
    tableView.separatorStyle = .none
    return tableView
  }()

  func registerCell(_ cell: AnyClass, identifier: String) {
    tableView.register(cell, forCellReuseIdentifier: identifier)
  }

  func setDelegate(_ delegate: UITableViewDelegate & UITableViewDataSource) {
    tableView.delegate = delegate
    tableView.dataSource = delegate
  }

  func reload() {
    tableView.reloadData()
    refreshControl.endRefreshing()
  }

  override func addSubviews() {
    tableView.addSubview(refreshControl)
    self.addSubview(container)
    container.addSubview(tableView)
  }

  override func installConstraints() {
    var constraints = [
      container.topAnchor.constraint(equalTo: self.topAnchor),
      container.bottomAnchor.constraint(equalTo: self.bottomAnchor),
      container.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      container.trailingAnchor.constraint(equalTo: self.trailingAnchor)
    ]
    constraints += [
      tableView.topAnchor.constraint(equalTo: container.topAnchor),
      tableView.bottomAnchor.constraint(equalTo: container.bottomAnchor),
      tableView.leadingAnchor.constraint(equalTo: container.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: container.trailingAnchor)
    ]
    NSLayoutConstraint.activate(constraints)
  }
}
