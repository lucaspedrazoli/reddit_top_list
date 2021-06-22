//
//  TopListViewModel.swift
//  RedditTopList
//
//  Created by Lucas Pedrazoli on 22/06/21.
//

import Foundation

class TopListViewModel {

  let topListRepository: TopListRepositoryType
  private var lastItemId: String?
  private var isPaginating = false

  init(topListRepository: TopListRepositoryType) {
    self.topListRepository = topListRepository
  }

  func load(_ completion: @escaping ([TopListElement]) -> Void) {
    topListRepository.getList { [weak self] element in
      guard let self = self else { return }
      let newList = element?.data.children.map { $0.data }
      self.lastItemId = element?.data.after
      completion(newList ?? [])
    }
  }

  func handlePagination(itemsCount: Int,
                        currentRow: Int,
                        _ completion: @escaping ([TopListElement]) -> Void) {
    guard let id = lastItemId,
          !isPaginating,
          isLastRow(totalRows: itemsCount, currentRow: currentRow) else { return }
    isPaginating = true
    topListRepository.paginate(lastItemId: id, itemsCount: itemsCount) { [weak self] element in
      guard let self = self else { return }
      self.lastItemId = element?.data.after
      let newList = element?.data.children.map { $0.data }
      completion(newList ?? [])
      self.isPaginating = false
    }
  }

  private func isLastRow(totalRows: Int, currentRow: Int) -> Bool {
    return (totalRows - 1) == currentRow
  }
}
