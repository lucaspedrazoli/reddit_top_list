//
//  TopListCell.swift
//  RedditTopList
//
//  Created by Lucas Pedrazoli on 22/06/21.
//

import Foundation
import UIKit

class TopListCell: UITableViewCell {

  lazy var container: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.layer.borderWidth = 2.0
    view.layer.borderColor = UIColor.black.cgColor
    view.layer.cornerRadius = 8.0
    view.backgroundColor = .blue
    return view
  }()

  lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  static func dequeue(for tableview: UITableView,
                      at indexPath: IndexPath,
                      from item: TopListElement) -> UITableViewCell {
    let cell = tableview.dequeueReusableCell(withIdentifier: TopListCell.identifier, for: indexPath)
    guard let topListCell = cell as? TopListCell else { return cell }
    topListCell.inflate(with: item.title)
    return cell
  }

  func inflate(with text: String) {
    titleLabel.text = text
    addSubviews()
    installConstraints()
  }

  private func addSubviews() {
    contentView.addSubview(container)
    container.addSubview(titleLabel)
  }

  private func installConstraints() {
    let margin = contentView.layoutMarginsGuide
    var constraints = [
      container.topAnchor.constraint(equalTo: margin.topAnchor),
      container.bottomAnchor.constraint(equalTo: margin.bottomAnchor),
      container.leadingAnchor.constraint(equalTo: margin.leadingAnchor),
      container.trailingAnchor.constraint(equalTo: margin.trailingAnchor),
    ]
    constraints += [
      titleLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 10),
      titleLabel.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.8),
      titleLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 10),
      titleLabel.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -10),
    ]
    NSLayoutConstraint.activate(constraints)
  }
}
