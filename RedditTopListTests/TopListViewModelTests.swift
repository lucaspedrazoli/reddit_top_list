//
//  TopListViewModelTests.swift
//  RedditTopListTests
//
//  Created by Lucas Pedrazoli on 29/06/21.
//

import Foundation
import XCTest
@testable import RedditTopList

class TopListViewModelTests: XCTestCase {

  var viewModel: TopListViewModel!

  override func setUp() {
    super.setUp()
    var repository = TopListRepositoryMock()
    repository.topList = createTopList()
    viewModel = TopListViewModel(topListRepository: repository)
  }

  override func tearDown() {
    super.tearDown()
    viewModel = nil
  }

  func testPaginationNotLastRow() {
    var paginated = false
    viewModel.handlePagination(itemsCount: 10, currentRow: 1, { _ in
      paginated = true
    })
    XCTAssertFalse(paginated)
  }

  func testPaginationLastRow() {
    var paginated = false
    viewModel.load({ _ in })
    viewModel.handlePagination(itemsCount: 11, currentRow: 10, { _ in
      paginated = true
    })
    XCTAssertTrue(paginated)
  }

  private func createTopList() -> TopList{
    let topListElement = TopListElement.empty()
    let elementData = TopList.ListElementData(data: topListElement)
    let topListData = TopList.ListData(children: [elementData], after: "id")
    let toplist = TopList(data: topListData)
    return toplist
  }
}

