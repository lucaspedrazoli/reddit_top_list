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

  lazy var spinner: UIActivityIndicatorView = {
    let spinner = UIActivityIndicatorView(style: .large)
    spinner.color = .black
    spinner.translatesAutoresizingMaskIntoConstraints = false
    spinner.isHidden = true
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

  override func addSubviews() {
    self.addSubview(container)
    container.addSubview(tableView)
    container.addSubview(spinner)
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
    constraints += [
      spinner.centerXAnchor.constraint(equalTo: tableView.centerXAnchor),
      spinner.centerYAnchor.constraint(equalTo: tableView.centerYAnchor),
    ]
    NSLayoutConstraint.activate(constraints)
  }

  func showLoading() {
    spinner.startAnimating()
    spinner.isHidden = false
  }

  func hideLoading() {
    spinner.stopAnimating()
    spinner.isHidden = true
  }
}
