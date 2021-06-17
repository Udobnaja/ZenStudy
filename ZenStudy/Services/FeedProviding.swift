///
// Created by Anna Udobnaja on 18.05.2021.

import UIKit
import ZenCore

protocol FeedProviding {
  var network: NetworkServicing { get }

  func loadFeed(
    from url: URL,
    completion: @escaping (Result<Feed, Error>) -> Void
  )

  func cancel()
}

class FeedProvider: FeedProviding {
  var network: NetworkServicing

  private var task: HTTPTask?

  init(network: NetworkServicing) {
    self.network = network
  }

  func loadFeed(
    from url: URL,
    completion: @escaping (Result<Feed, Error>) -> Void
  ) {
    task?.cancel()

    let request = NetworkRequest(destination: .url(url), requiredMethod: .get)

    task = network.executeRequest(request) { result in
      switch result {
      case let .success(data):
        guard let data = data else {
          preconditionFailure("Empty Data")
        }

        do {
          let decodedObject = try JSONDecoder().decode(Feed.self, from: data)
          completion(.success(decodedObject))
        } catch {
          completion(.failure(error))
        }

      case let .failure(error):
        completion(.failure(error))
      }
    }
  }

  func cancel() {
    task?.cancel()
  }
}
