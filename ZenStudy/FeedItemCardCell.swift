//
//  FeedItemView.swift
//  ZenStudy
//
//  Created by Anna Udobnaja on 30.04.2021.
//

import UIKit

class FeedItemCardCell: UICollectionViewCell {
  lazy var cardView = makeCardView()

  override init(frame: CGRect) {
    super.init(frame: frame)

    setupLayout()
  }

  override func prepareForReuse() {
      super.prepareForReuse()
  }

  private func setupLayout() {
    translatesAutoresizingMaskIntoConstraints = false

    contentView.addSubview(cardView)

    cardView.pinEdgesToSuperview()
  }

  required init?(coder: NSCoder) {
    fatalError("Init(coder:) has not been implemented")
  }

  private func makeCardView() -> CardView {
    let cardView = CardView.newAutoLayout()

    cardView.layer.cornerRadius = Styles.feedCellCornerRadius
    cardView.clipsToBounds = true

    return cardView
  }

  func configure(
    with model: CellModel
  ){
    cardView.configure(with: model)
  }
}

extension FeedItemCardCell {
  static func height(with model: CellModel, for item: FeedItem) -> CGFloat {
    let header = CardHeader.height()
    let footer = CardFooter.height()

    let height: CGFloat =
      header +
      CardContent.height(with: model.cardContentModel) +
      footer
    
    return height
  }
}
