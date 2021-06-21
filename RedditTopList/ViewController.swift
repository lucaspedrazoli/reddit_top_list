//
//  ViewController.swift
//  RedditTopList
//
//  Created by Lucas Pedrazoli on 21/06/21.
//

import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .yellow
    let storage = UserSessionDataSource()
    storage.write("foo", for: "bar")
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
      let value: String? = storage.read(for: "bar")
      print(value)
    }
  }

  private func callApi() {
    var request = Request(endpoint: .topList, method: .GET)
    request.addHeader("Authorization", "Bearer ")
    let network = NetworkDataSource<TopList>()
    network.doRequest(request, completion: {
      print($0?.data.children.first?.data.title ?? "error")
    })
  }
}

