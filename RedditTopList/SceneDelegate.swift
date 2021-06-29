//
//  SceneDelegate.swift
//  RedditTopList
//
//  Created by Lucas Pedrazoli on 21/06/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?

  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = (scene as? UIWindowScene) else { return }
    let dependencyContainer = DependencyContainer()
    let navigation = dependencyContainer.makeInitialController(for: UIDevice.current.userInterfaceIdiom)
    navigation.restorationIdentifier = "RootNavigationController"
    if let userActivity = connectionOptions.userActivities.first ?? session.stateRestorationActivity {
      let viewController = navigation.children.first! as! ViewController
      viewController.continueFrom(activity: userActivity)
    }
    window = UIWindow(windowScene: windowScene)
    window?.rootViewController = navigation
    window?.makeKeyAndVisible()
  }

  func stateRestorationActivity(for scene: UIScene) -> NSUserActivity? {
    if let nc = self.window?.rootViewController as? UINavigationController, let vc = nc.viewControllers.first as? ViewController {
      return vc.continuationActivity
    } else {
      return nil
    }
  }

}

