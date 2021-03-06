//
//  ReloadCellDelegate.swift
//  RedditTopList
//
//  Created by Lucas Pedrazoli on 23/06/21.
//

import UIKit

protocol ReloadCellDelegate: AnyObject {
  func reloadCell(at indexPath: IndexPath)
}
