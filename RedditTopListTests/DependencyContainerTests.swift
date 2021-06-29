//
//  DependencyContainerTests.swift
//  RedditTopListTests
//
//  Created by Lucas Pedrazoli on 29/06/21.
//

import Foundation
import XCTest
@testable import RedditTopList

class DependencyContainerTests: XCTestCase {

  var container: DependencyContainer!

  override func setUp() {
    super.setUp()
    container = DependencyContainer()
  }

  override func tearDown() {
    super.tearDown()
    container = nil
  }

  func testPadInitialController() {
    let initialViewController = container.makeInitialController(for: .pad)
    XCTAssert(initialViewController.isKind(of: UISplitViewController.self))
  }

  func testNotPadInitialController() {
    let initialViewController = container.makeInitialController(for: .phone)
    XCTAssert(initialViewController.isKind(of: UINavigationController.self))
    XCTAssert(initialViewController.children.first!.isKind(of: ViewController.self))
  }

}
