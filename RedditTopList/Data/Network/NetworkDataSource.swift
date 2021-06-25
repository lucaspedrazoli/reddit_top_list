//
//  NetworkDataSource.swift
//  RedditTopList
//
//  Created by Lucas Pedrazoli on 21/06/21.
//

import Foundation

struct NetworkDataSource: NetworkDataSourceType {

  private var session: URLSession {
    let configuration = URLSessionConfiguration.default
    let session = URLSession(configuration: configuration)
    return session
  }

  func doRequest<T: Codable>(_ request: Request, completion: @escaping (T?) -> Void) {
    let _request = request.build()
    let task = session
         .dataTask(with: _request) { (data, response, error) in

           if let error = error {
             print("data task error: \(error)")
             return
           }

          guard let httpResponse = response as? HTTPURLResponse  else {
            let info = [
              "http_response_error": "unexpected_response_error",
              "url": "\(String(describing: _request.url))"
            ]
            print(info)
            return
          }

          guard 200..<300 ~= httpResponse.statusCode else {
            print("unexpected status code: \(httpResponse.statusCode)")
            return
          }

          if let data = data {
            let model = try? JSONDecoder().decode(T.self, from: data)
            print("================= Network Success =================")
            //print("\(String(describing: model))")
            completion(model)
          }
      }
    task.resume()
  }
}
