//
//  AppDelegate.swift
//  RedditTopList
//
//  Created by Lucas Pedrazoli on 21/06/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    Environment.run()
    let window = UIWindow(frame: UIScreen.main.bounds)
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let initialViewController = storyboard.instantiateViewController(withIdentifier: "ViewController")
    window.rootViewController = initialViewController
    window.makeKeyAndVisible()
    return true
  }

  func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
    return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
  }

  func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {

  }
}

