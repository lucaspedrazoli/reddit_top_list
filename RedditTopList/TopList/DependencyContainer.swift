//
//  DependencyContainer.swift
//  RedditTopList
//
//  Created by Lucas Pedrazoli on 22/06/21.
//

import Foundation
import UIKit

struct DependencyContainer {
  let networkDataSource = NetworkDataSource()
  let userSessionDataSource = UserSessionDataSource()
  let requestFactory = RequestFactory()

  func makeTopListViewController() -> ViewController {
    let topListRepository = TopListRepository(network: networkDataSource,
                                              userSession: userSessionDataSource,
                                              requestFactory: requestFactory)
    let viewModel = TopListViewModel(topListRepository: topListRepository)
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let viewController = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
    viewController.viewModel = viewModel
    viewController.topListView = TopListView()
    return viewController
  }
}
