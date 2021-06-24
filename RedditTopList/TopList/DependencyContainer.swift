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

  private func makeTopListViewController() -> ViewController {
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

  private func makeSplitViewController() -> UISplitViewController {
    let splitViewController = UISplitViewController()
    let listNavigationController = UINavigationController(rootViewController: makeTopListViewController())
    let detailViewController = DetailViewController()
    let detailNavigationController = UINavigationController(rootViewController: detailViewController)
    splitViewController.viewControllers = [listNavigationController, detailNavigationController]
    return splitViewController
  }

  func makeInitialController() -> UIViewController {
    if UIDevice.current.userInterfaceIdiom == .pad {
      return makeSplitViewController()
    } else {
      return  UINavigationController(rootViewController: makeTopListViewController())
    }
  }
}
