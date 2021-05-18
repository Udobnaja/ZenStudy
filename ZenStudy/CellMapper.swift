//
//  Mapper.swift
//  ZenStudy
//
//  Created by Anna Udobnaja on 10.05.2021.
//

import UIKit

class CellMapper {

  func map(
    item: FeedItem,
    cellWidth: CGFloat,
    cellContentWidth: CGFloat,
    theme: Theme
  ) -> CellModel {

    var multiplier: CGFloat = ImageAspectRatio.rectangle
    var title = item.title ?? ""
    var subtitle = item.text

    if (title.isEmpty) {
      title = subtitle
      subtitle = ""
    }

    if title.count < 60 {
      multiplier = ImageAspectRatio.album
    }

    if subtitle.isEmpty {
      multiplier = ImageAspectRatio.square
    }

    if item.image == nil {
      multiplier = .zero
    }

    var cardHeaderModel: CardHeaderModel?

    if let source = item.source {
      cardHeaderModel = CardHeaderModel(avatarSrc: source.logo, title: source.title, isSubscribed: source.status == "subscribed")
    }

    //print(FeedItem.itemType(rawValue: item))
    
    return CellModel(
      cardHeaderModel: cardHeaderModel,
      cardContentModel: CardContentModel(
        imageSrc: item.image,
        text: subtitle,
        title: title,
        createDate: item.creationTime,
        thumbAspectRatio: multiplier,
        cellContentWidth: cellContentWidth,
        cellWidth: cellWidth
      ),
      theme: theme
    )
  }
}
