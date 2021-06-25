//
//  UIImageView.swift
//  RedditTopList
//
//  Created by Lucas Pedrazoli on 23/06/21.
//

import UIKit

extension UIImageView {
  func load(url: String) {
    let placeholder =  UIImage(named: "placeholder")
    addImageWithFade(placeholder, interval: 0.3, alpha: 0.5)
    guard let url = URL(string: url),
          url != URL(string: "nsfw") else { return }
    DispatchQueue.global(qos: .background).async { [weak self] in
      guard let data = try? Data(contentsOf: url) else { return }
      guard let image = UIImage(data: data) else { return }
      DispatchQueue.main.async {
        self?.addImageWithFade(image, interval: 0.3)
      }
    }
  }

  func addImageWithFade(_ image: UIImage?,
                        interval: TimeInterval = 0.5,
                        alpha: CGFloat = 1.0) {
    UIView.animate(withDuration: interval) { [weak self] in
      self?.alpha = 0
      self?.image = image
      self?.alpha = alpha
    }
  }
}
