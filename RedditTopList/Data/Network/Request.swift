//
//  Request.swift
//  RedditTopList
//
//  Created by Lucas Pedrazoli on 21/06/21.
//

import Foundation

struct Request {

  var endpoint: Endpoint
  var method: HTTPVerb
  var params: Array<URLQueryItem> = []
  var body: [String: Any] = [:]
  var header: [String: String?] = [:]

  init(endpoint: Endpoint, method: HTTPVerb) {
    self.endpoint = endpoint
    self.method = method
  }

  mutating func addQueryItem(_ key: QueryKey, value: String?) {
    let queryItem = URLQueryItem(name: key.rawValue, value: value)
    params.append(queryItem)
  }

  mutating func addHeader(_ name: String, _ value: String?) {
    header[name] = value
  }

  mutating func addBearerToken(_ token: String?) {
    header[HeaderKey.authorization.rawValue] = "Bearer \(token ?? "")"
  }

  mutating func addBasicAuth(_ id: String?) {
    header[HeaderKey.basic.rawValue] = "Basic \(id ?? "")"
  }

  func build() -> URLRequest {
    var urlComponents = URLComponents(url: endpoint.rawValue,
                                            resolvingAgainstBaseURL: false)!
    urlComponents.queryItems = params
    var urlRequest = URLRequest(url: urlComponents.url!)
    _ = header.map { urlRequest.addValue($0.value ?? "", forHTTPHeaderField: $0.key) }
    urlRequest.httpMethod = method.rawValue
    return urlRequest
  }
}
