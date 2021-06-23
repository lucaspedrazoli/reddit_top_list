//
//  TopListCell.swift
//  RedditTopList
//
//  Created by Lucas Pedrazoli on 22/06/21.
//

import Foundation
import UIKit

class TopListCell: UITableViewCell {

  var item: TopListElement?
  var indexPath: IndexPath?
  var reloadDelegate: ReloadCellDelegate?

  lazy var container: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.layer.borderWidth = 2.0
    view.layer.borderColor = UIColor.black.cgColor
    view.layer.cornerRadius = 8.0
    view.backgroundColor = .gray
    return view
  }()

  lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    label.textAlignment = .center
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  lazy var authorLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    label.textAlignment = .center
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  lazy var entryDateLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    label.textAlignment = .center
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  lazy var commentsLabel: UILabel = {
    let label = UILabel()
    label.textAlignment = .center
    label.numberOfLines = 0
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  lazy var statusLabel: UILabel = {
    let label = UILabel()
    label.textAlignment = .center
    label.numberOfLines = 0
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  lazy var thumbnail: UIImageView = {
    let imageView = UIImageView()
    imageView.layer.cornerRadius = 16.0
    imageView.clipsToBounds = true
    imageView.translatesAutoresizingMaskIntoConstraints = false
    let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
    imageView.isUserInteractionEnabled = true
    imageView.addGestureRecognizer(tapGestureRecognizer)
    return imageView
  }()

  static func dequeue(for tableview: UITableView,
                      at indexPath: IndexPath,
                      from item: TopListElement) -> TopListCell? {
    let cell = tableview.dequeueReusableCell(withIdentifier: TopListCell.identifier, for: indexPath)
    guard let topListCell = cell as? TopListCell else { return nil }
    topListCell.inflate(with: item)
    topListCell.item = item
    topListCell.indexPath = indexPath
    return topListCell
  }

  func inflate(with item: TopListElement) {
    authorLabel.text = "author: \(item.author)"
    entryDateLabel.text = Date.elapsedTime(timestamp: item.createdAt)
    thumbnail.load(url: item.thumbnail)
    commentsLabel.text = "comments: \(item.commentsCount)"
    statusLabel.text = "status: \(item.status())"
    titleLabel.text = "title: \(item.title)"
    addSubviews()
    installConstraints()
  }

  @objc func imageTapped() {
    guard let item = item,
          let url = URL(string: item.url) else { return }
    DispatchQueue.global(qos: .background).async {
      if let data = try? Data(contentsOf: url),
         let image = UIImage(data: data) {
          UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        DispatchQueue.main.async {
          UIApplication.shared.open(url)
        }
      }
    }
  }

  private func addSubviews() {
    contentView.addSubview(container)
    container.addSubview(authorLabel)
    container.addSubview(entryDateLabel)
    container.addSubview(thumbnail)
    container.addSubview(commentsLabel)
    container.addSubview(statusLabel)
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
      authorLabel.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.8),
      authorLabel.centerXAnchor.constraint(equalTo: container.centerXAnchor),
      authorLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 10),
      authorLabel.bottomAnchor.constraint(equalTo: entryDateLabel.topAnchor),
    ]
    constraints += [
      entryDateLabel.centerXAnchor.constraint(equalTo: container.centerXAnchor),
      entryDateLabel.bottomAnchor.constraint(equalTo: thumbnail.topAnchor, constant: -10)
    ]
    constraints += [
      thumbnail.centerXAnchor.constraint(equalTo: container.centerXAnchor),
      thumbnail.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.25),
      thumbnail.heightAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.25),
      thumbnail.bottomAnchor.constraint(equalTo: commentsLabel.topAnchor, constant: -10)
    ]
    constraints += [
      commentsLabel.centerXAnchor.constraint(equalTo: container.centerXAnchor),
      commentsLabel.bottomAnchor.constraint(equalTo: statusLabel.topAnchor)
    ]
    constraints += [
      statusLabel.centerXAnchor.constraint(equalTo: container.centerXAnchor),
      statusLabel.bottomAnchor.constraint(equalTo: titleLabel.topAnchor)
    ]
    constraints += [
      titleLabel.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.8),
      titleLabel.centerXAnchor.constraint(equalTo: container.centerXAnchor),
      titleLabel.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -10)
    ]
    NSLayoutConstraint.activate(constraints)
  }
}
