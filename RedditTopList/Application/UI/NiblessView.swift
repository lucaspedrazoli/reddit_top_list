//
//  NiblessView.swift
//  RedditTopList
//
//  Created by Lucas Pedrazoli on 22/06/21.
//

import Foundation
import UIKit

class NiblessView: UIView {

  public override init(frame: CGRect) {
    super.init(frame: frame)
  }

  final func inflate(with frame: CGRect) {
    self.frame = frame
    addSubviews()
    installConstraints()
  }

  func addSubviews() {}

  func installConstraints() {}

  @available(*, unavailable,
    message: "Loading this view controller from a nib is unsupported."
  )

  public required init?(coder aDecoder: NSCoder) {
    fatalError("Loading this view from a nib is unsupported.")
  }
}
