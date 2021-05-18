//
//  Styles.swift
//  ZenStudy
//
//  Created by Anna Udobnaja on 30.04.2021.
//

import UIKit

public enum Styles {
  public static let feedCellContentInset: CGFloat = 4
  public static let feedColumnSpacing: CGFloat = 12
  public private(set) static var feedCellContentCornerRadius: CGFloat = 20
  public private(set) static var feedCellCornerRadius: CGFloat = 24
  public private(set) static var feedCellsLineSpacing: CGFloat = 12
  private static var feedCellsMinLeftInset: CGFloat = 0
  private static var feedCellsMinRightInset: CGFloat = 0
  private static var maxCellWidth: CGFloat?

  public static var numberOfColumnsInFeed: Int {
    let isIPad = UIDevice.current.userInterfaceIdiom == .pad
    return isIPad ? 2 : 1
  }

  public static func feedCellsWidth(
    for collectionView: UICollectionView
  ) -> CGFloat {
    let numberOfColumns = Self.numberOfColumnsInFeed
    var feedWidth = collectionView.bounds.width
    feedWidth -= feedColumnSpacing * CGFloat(numberOfColumns - 1)
    feedWidth /= CGFloat(numberOfColumns)

    if let maxWidth = maxCellWidth {
      // Substract insets before comparing because maxCellWidth does not include them
      feedWidth -= feedCellsMinLeftInset
      feedWidth -= feedCellsMinRightInset
      feedWidth = min(feedWidth, maxWidth)
    } else {
      feedWidth = min(feedWidth, collectionView.bounds.height)
      feedWidth -= feedCellsMinLeftInset
      feedWidth -= feedCellsMinRightInset
    }

    return max(0, feedWidth)
  }

  public static func feedCellSideInset(
    for collectionView: UICollectionView
  ) -> CGFloat {
    let isIPad = UIDevice.current.userInterfaceIdiom == .pad
    if isIPad {
      switch collectionView.bounds.width {
      case ..<834:
        return 32
      case 834...:
        return 64
      default:
        return 0
      }
    } else {
      let cellWidth = feedCellsWidth(for: collectionView)
      let numberOfColumns = Self.numberOfColumnsInFeed
      let totalWidth = collectionView.bounds.width
      var sideInset = totalWidth
      sideInset -= cellWidth * CGFloat(numberOfColumns)
      sideInset -= feedColumnSpacing * CGFloat(numberOfColumns - 1)
      sideInset /= 2

      return sideInset
    }
  }

  public static func feedCollectionViewWidth(
    for containerWidth: CGFloat
  ) -> CGFloat {
    let isIPad = UIDevice.current.userInterfaceIdiom == .pad
    if isIPad {
      switch containerWidth {
      case ..<834:
        return 768
      case 834..<1024:
        return 932
      case 1024...:
        return 1024
      default:
        return containerWidth
      }
    } else {
      return containerWidth
    }
  }

  public static func setFeedCellCornerRadius(_ value: CGFloat) {
    feedCellCornerRadius = value
    feedCellContentCornerRadius = value - feedCellContentInset
  }

  public static func setFeedCellLineSpacing(_ value: CGFloat) {
    feedCellsLineSpacing = value
  }

  public static func setMaxCellWidth(_ value: CGFloat) {
    maxCellWidth = value
  }

//  public static func updateFeedSideInsets(
//    left: CGFloat,
//    right: CGFloat,
//    for collectionView: UICollectionView
//  ) -> Bool {
//    let previousCellWidth = feedCellsWidth(for: collectionView)
//
//    feedCellsMinLeftInset = left
//    feedCellsMinRightInset = right
//
//    let newCellWidth = feedCellsWidth(for: collectionView)
//
//    return previousCellWidth != newCellWidth
//  }
}
