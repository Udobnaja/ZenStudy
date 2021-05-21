///
// Created by Anna Udobnaja on 18.05.2021.

import Foundation
import UIKit

protocol FeedProviding {
  var network: Networking { get }

  func loadFeed(from url: URL, completion: @escaping (Result<Feed, Error>) -> Void)

  func cancel()
}

class FeedProvider: FeedProviding {
  var network: Networking

  private var task: URLSessionDataTask?

  init(network: Networking) {
    self.network = network
  }

  func loadFeed(from url: URL, completion: @escaping (Result<Feed, Error>) -> Void) {
    task?.cancel()

    task = network.fetch(url: url, completion: completion)

    task?.resume()
  }

  func cancel() {
    task?.cancel()
  }
}
