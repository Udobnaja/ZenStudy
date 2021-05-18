//
//  CardView.swift
//  ZenStudy
//
//  Created by Anna Udobnaja on 30.04.2021.
//

import UIKit

class CardView: UIView {
  lazy var stackView = makeStackView()
  lazy var cardContentView = makeContentView()
  lazy var cardFooterView = makeCardFooterView()
  lazy var cardHeaderView = makeCardHeaderView()

  override init(frame: CGRect) {
    super.init(frame: frame)

    setupLayout()
  }

  private func setupLayout() {
    clipsToBounds = true

    addSubview(stackView)

    stackView.pinEdgesToSuperview()

    for view in [cardHeaderView, cardContentView, cardFooterView] {
      stackView.addArrangedSubview(view)
    }
  }

  required init?(coder: NSCoder) {
    fatalError("Init(coder:) has not been implemented")
  }

  private func makeStackView() -> UIStackView {
    let stackView = UIStackView.newAutoLayout()

    stackView.axis = .vertical
    stackView.distribution = .fill
    stackView.spacing = 0

    return stackView
  }

  private func makeContentView() -> CardContent {
    let view = CardContent.newAutoLayout()

    return view
  }

  private func makeCardHeaderView() -> CardHeader {
    let view = CardHeader.newAutoLayout()

    return view
  }

  private func makeCardFooterView() -> CardFooter {
    let view = CardFooter.newAutoLayout()

    return view
  }

  private func setupTheme(theme: Theme) {
    switch theme {
      case .light:
        backgroundColor = Styles.Colors.Background.primary
      case .dark:
        backgroundColor = Styles.Colors.Background.primaryInverted
      }
  }

  func configure(
    with model: CellModel
  ){
    setupTheme(theme: model.theme)

    if let cardHeaderModel = model.cardHeaderModel {
      cardHeaderView.configure(with: cardHeaderModel, theme: model.theme)
    }

    cardContentView.configure(with: model.cardContentModel, theme: model.theme)
    cardFooterView.configure(theme: model.theme)
  }

}
