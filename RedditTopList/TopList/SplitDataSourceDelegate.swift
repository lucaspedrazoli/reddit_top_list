//
//  SplitDataSourceDelegate.swift
//  RedditTopList
//
//  Created by Lucas Pedrazoli on 23/06/21.
//

protocol SplitDataSourceDelegate {
  func didSelectItem<T>(_ completion: (T) -> Void)
}
