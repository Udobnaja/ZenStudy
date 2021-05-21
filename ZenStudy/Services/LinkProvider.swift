///
//  Created by Anna Udobnaja on 21.05.2021.

import UIKit
import ZenCore

class LinkProvider: APIComponentsProviding, BulkStatEventsLinkProviding {
  var bulkStatEventsURL: URL?

  var basePath: String = ""
  var apiDomain: String = ""

  init() {
    basePath = "/api/v3/launcher"
    apiDomain = "zen.yandex.com"
  }
}
