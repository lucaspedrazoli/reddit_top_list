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
    let splitViewController = UISplitViewController(style: .doubleColumn)
    let detailViewController = DetailViewController()
    let listViewController = makeTopListViewController()
    listViewController.splitControllerDelegate = detailViewController
    let listNavigationController = UINavigationController(rootViewController: listViewController)
    let detailNavigationController = UINavigationController(rootViewController: detailViewController)
    splitViewController.preferredDisplayMode = .oneBesideSecondary
    splitViewController.setViewController(listNavigationController, for: .primary)
    splitViewController.setViewController(detailNavigationController, for: .secondary)
    return splitViewController
  }

  func makeInitialController(for device: UIUserInterfaceIdiom) -> UIViewController {
    if device == .pad {
      return makeSplitViewController()
    } else {
      let navigationController = UINavigationController(rootViewController: makeTopListViewController())
      return navigationController
    }
  }
}
