///
//  Created by Anna Udobnaja on 29.04.2021.

import Foundation

struct FeedItem: Codable, Equatable {
  let id: String?
  let title: String?
  let image: String?
  let text: String?
  let cardType: String?
  let itemType: String?
  let source: Source?
  let creationTime: String?
  let isFavorited: Bool?

  enum CodingKeys: String, CodingKey {
      case cardType = "card_type"
      case itemType = "item_type"
      case creationTime = "creation_time"
      case isFavorited = "is_favorited"

      case id
      case title
      case image
      case text
      case source
  }

  enum ItemType {
    case imageText
    case text

    init(rawValue: FeedItem) {
      switch rawValue.image {
      case nil: self = .text
      default: self = .imageText
      }
    }
  }
}
