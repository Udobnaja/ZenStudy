///
//  Created by Anna Udobnaja on 21.05.2021.

import Foundation

import ZenCore

class AuthorizationHeadersAdapter: AuthorizationHeadersProviding {
  func getAuthorizationHeaders(
    forRequestTo url: URL,
    _ completion: @escaping ([String: String]) -> Void
  ) {
    completion([String: String]())
  }
}
