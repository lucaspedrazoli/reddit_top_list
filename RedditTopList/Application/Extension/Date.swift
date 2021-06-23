//
//  Date.swift
//  RedditTopList
//
//  Created by Lucas Pedrazoli on 23/06/21.
//

import Foundation

extension Date {
  static func elapsedTime(timestamp: Double) -> String {
    let date = Date(timeIntervalSince1970: timestamp)
    let formatter = RelativeDateTimeFormatter()
    formatter.unitsStyle = .full
    return formatter.localizedString(for: date, relativeTo: Date())
  }
}
