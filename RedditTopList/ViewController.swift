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
    var request = Request(endpoint: .topList, method: .GET)
    request.addHeader("Authorization", "Bearer 707316452692-3pQSWH__jBdIbX6lMLg27BgQ6uOMgw")
    let network = NetworkDataSource<TopList>()
    network.doRequest(request, completion: {
      print($0?.data.children.first?.data.title ?? "error")
    })
  }
}

