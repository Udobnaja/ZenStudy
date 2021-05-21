///
//  Created by Anna Udobnaja on 21.05.2021.

import ZenCore

class QueryParametersProvider: QueryParametersProviding {

  func getQueryParameters(
    _ completion: @escaping ([String: String]) -> Void
  ) {
    completion([String: String]())
  }
}
