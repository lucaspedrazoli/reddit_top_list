//
//  DetailViewController.swift
//  RedditTopList
//
//  Created by Lucas Pedrazoli on 23/06/21.
//

import Foundation
import UIKit

class DetailViewController: NiblessViewController, SplitControllerlegate {

  var item: TopListElement?

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
    label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
    label.numberOfLines = 0
    label.textAlignment = .center
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  lazy var authorLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
    label.numberOfLines = 0
    label.textAlignment = .center
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  lazy var entryDateLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 30)
    label.numberOfLines = 0
    label.textAlignment = .center
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  lazy var commentsLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 30)
    label.textAlignment = .center
    label.numberOfLines = 0
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  lazy var statusLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 30)
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

  override func viewDidLoad() {
    super.viewDidLoad()
    addSubviews()
    installConstraints()
  }

  func showDetailItem(_ item: TopListElement?) {
    guard let item = item else { return }
    self.item = item
    authorLabel.text = "author: \(item.author)"
    entryDateLabel.text = Date.elapsedTime(timestamp: item.createdAt)
    thumbnail.load(url: item.thumbnail)
    commentsLabel.text = "comments: \(item.commentsCount)"
    statusLabel.text = "status: \(item.status())"
    titleLabel.text = "title: \(item.title)"
  }

  @objc func imageTapped() {
    guard let item = item,
          let url = URL(string: item.url),
          item.isImage() else {
      shake()
      return
    }
    UIApplication.shared.open(url)
    DispatchQueue.global(qos: .background).async {
      if let data = try? Data(contentsOf: url),
         let image = UIImage(data: data) {
          UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
      }
    }
  }

  func shake() {
    let shake = CASpringAnimation(keyPath: "position.x")
    shake.fromValue = thumbnail.layer.position.x + 5.0
    shake.toValue = thumbnail.layer.position.x
    shake.duration = shake.settlingDuration
    thumbnail.layer.add(shake, forKey: nil)
  }

  private func addSubviews() {
    view.addSubview(container)
    container.addSubview(authorLabel)
    container.addSubview(entryDateLabel)
    container.addSubview(thumbnail)
    container.addSubview(commentsLabel)
    container.addSubview(statusLabel)
    container.addSubview(titleLabel)
  }

  private func installConstraints() {
    let margin = view.layoutMarginsGuide
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
      titleLabel.heightAnchor.constraint(equalToConstant: 50)
    ]
    NSLayoutConstraint.activate(constraints)
  }

}
