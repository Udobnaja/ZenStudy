///
// Created by Anna Udobnaja on 18.05.2021.

import UIKit
protocol Networking {
  func fetch<T: Decodable>(
    url: URL,
    completion: @escaping (Result<T, Error>) -> Void
  ) -> URLSessionDataTask
}

extension Networking {
  func fetch<T: Decodable>(
    url: URL,
    completion: @escaping (Result<T, Error>) -> Void
  ) -> URLSessionDataTask {
    let urlRequest = URLRequest(url: url)
    let defaultSession = URLSession(configuration: .default)

    return defaultSession.dataTask(with: urlRequest) { data, _, error in
      do {
        if let error = error {
          completion(.failure(error))
          return
        }

        guard let data = data else {
          preconditionFailure("Empty Data")
        }

        let decodedObject = try JSONDecoder().decode(T.self, from: data)

        completion(.success(decodedObject))
      } catch {
        completion(.failure(error))
      }
    }
  }
}

class Network: Networking {}

//    private var successCodes: CountableRange<Int> = 200..<299
//    private var failureCodes: CountableRange<Int> = 400..<499
