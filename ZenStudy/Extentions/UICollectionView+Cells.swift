///
//  Created by Anna Udobnaja on 30.04.2021.

import UIKit

public extension UICollectionView {
  func register(_ cellClass: AnyClass) {
    register(cellClass, forCellWithReuseIdentifier: String(describing: cellClass))
  }

  func dequeue<T: UICollectionViewCell>(
    _ cellClass: T.Type,
    for indexPath: IndexPath
  ) -> T {
    guard
      let cell =
      dequeueReusableCell(
        withReuseIdentifier: String(describing: cellClass),
        for: indexPath
      ) as? T
    else {
      fatalError("Unable to dequeue reusable cell with type: \(T.self)")
    }

    return cell
  }

  func registerFooter(_ footerClass: AnyClass) {
    register(
      footerClass,
      forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
      withReuseIdentifier: String(describing: footerClass)
    )
  }

  func dequeueFooter<T: UICollectionReusableView>(
    _ footerClass: T.Type,
    for indexPath: IndexPath
  ) -> T {
    guard
      let footer =
      dequeueReusableSupplementaryView(
        ofKind: UICollectionView.elementKindSectionFooter,
        withReuseIdentifier: String(describing: footerClass),
        for: indexPath
      ) as? T
    else {
      fatalError("Unable to dequeue reusable footer with type: \(T.self)")
    }

    return footer
  }
}
