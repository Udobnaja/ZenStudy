///
//  Created by Anna Udobnaja on 04.05.2021.

import SDWebImage
import UIKit

class CardContent: UIView {
  lazy var stackView = makeContainerStackView()
  lazy var textStackView = makeStackView()
  lazy var thumbView = makeThumbView()
  lazy var titleView = makeTitleView()
  lazy var subtitleView = makeSubtitleView()
  lazy var additionalInfoLabel = makeAdditionalInfoLabel()

  override init(frame: CGRect) {
    super.init(frame: frame)

    setupLayout()

    configureViewActions()
  }

  required init?(coder: NSCoder) {
    fatalError("Init(coder:) has not been implemented")
  }

  private func setupLayout() {
    addSubview(stackView)

    stackView.pinEdgesToSuperview(
      with: UIEdgeInsets(
        top: 0,
        left: Styles.feedCellContentInset,
        bottom: 0,
        right: Styles.feedCellContentInset
      )
    )

    for view in [thumbView, textStackView] {
      stackView.addArrangedSubview(view)
    }

    textStackView.isLayoutMarginsRelativeArrangement = true
    textStackView.layoutMargins = UIEdgeInsets(
      top: .inset4,
      left: .inset16,
      bottom: 0,
      right: .inset16
    )

    for view in [
      SpacerView.height8,
      titleView,
      subtitleView,
      additionalInfoLabel,
      SpacerView.height16
    ] {
      textStackView.addArrangedSubview(view)
    }
  }

  private func configureViewActions() {
    let contentTap = UITapGestureRecognizer(
      target: self,
      action: #selector(handleContentAreaTap)
    )

    stackView.addGestureRecognizer(contentTap)
  }

  @objc func handleContentAreaTap(_ sender: UIStackView) {
    print("click to content area")
  }

  private func makeThumbView() -> UIImageView {
    let imageView = UIImageView.newAutoLayout()

    imageView.contentMode = .scaleAspectFill
    imageView.layer.borderWidth = Layout.imageViewBorderWidth
    imageView.layer.borderColor = Styles.Colors.Other.imageBorder.cgColor

    return imageView
  }

  private func makeStackView() -> UIStackView {
    let stackView = UIStackView.newAutoLayout()

    stackView.axis = .vertical
    stackView.spacing = 0
    stackView.clipsToBounds = true

    return stackView
  }

  private func makeContainerStackView() -> UIStackView {
    let stackView = makeStackView()

    stackView.layer.cornerRadius = Styles.feedCellContentCornerRadius

    return stackView
  }

  private func makeSubtitleView() -> UITextView {
    let subTitle = UITextView.newAutoLayout()

    subTitle.backgroundColor = .clear
    subTitle.font = Fonts.subtitle
    subTitle.textContainer.lineBreakMode = .byTruncatingTail
    subTitle.textContainer.lineFragmentPadding = 0
    subTitle.textContainerInset = .zero
    subTitle.isScrollEnabled = false

    return subTitle
  }

  private func makeTitleView() -> UITextView {
    let title = UITextView.newAutoLayout()

    title.font = Fonts.title
    title.backgroundColor = .clear
    title.isScrollEnabled = false
    title.textContainer.lineBreakMode = .byTruncatingTail
    title.textContainer.lineFragmentPadding = 0
    title.textContainerInset = .zero
    title.setContentHuggingPriority(.required, for: .vertical)

    return title
  }

  private func makeAdditionalInfoLabel() -> UILabel {
    let label = UILabel.newAutoLayout()
    label.numberOfLines = 1
    label.font = Fonts.additionalInfo

    return label
  }

  private func setupTheme(theme: Theme) {
    switch theme {
    case .light:
      stackView.backgroundColor = Styles.Colors.Background.secondary
      titleView.textColor = Styles.Colors.Text.primary
      subtitleView.textColor = Styles.Colors.Text.secondary
      additionalInfoLabel.textColor = Styles.Colors.Text.tetriary
    case .dark:
      stackView.backgroundColor = Styles.Colors.Background.secondaryInverted
      titleView.textColor = Styles.Colors.Text.primaryInverted
      subtitleView.textColor = Styles.Colors.Text.secondaryInverted
      additionalInfoLabel.textColor = Styles.Colors.Text.tetriaryInverted
    }
  }

  private func setupAdditionalInfoLabel(with model: CardContentModel) {
    if let createDate = model.createDate {
      additionalInfoLabel.text = createDate
      additionalInfoLabel.isHidden = false
      textStackView.setCustomSpacing(.inset2, after: subtitleView)
      additionalInfoLabel.setDimension(
        .height,
        to: CardContent.additionalInfoHeight(
          createDate: createDate,
          availableWidth: model.cellContentWidth
        )
      )
    } else {
      additionalInfoLabel.isHidden = true
      textStackView.setCustomSpacing(0, after: subtitleView)
    }
  }

  func configure(
    with model: CardContentModel,
    theme: Theme
  ) {
    setupTheme(theme: theme)

    let hasSubtitle = !model.text.isEmpty

    if let imageSrc = model.imageSrc {
        if let url = URL(string: imageSrc) {
          thumbView.sd_setImage(with: url)
          thumbView.isHidden = false
          titleView.textContainer.maximumNumberOfLines =
            Layout.titleMaximumNumberOfLines
          subtitleView.textContainer.maximumNumberOfLines = 3
          textStackView.layoutMargins = UIEdgeInsets(
            top: .inset4,
            left: .inset16,
            bottom: 0,
            right: .inset16
          )
        } else {
          titleView.textContainer.maximumNumberOfLines = 3
          subtitleView.textContainer.maximumNumberOfLines = 6
          thumbView.isHidden = true
          textStackView.layoutMargins = UIEdgeInsets(
            top: .inset12,
            left: .inset16,
            bottom: 0,
            right: .inset16
          )
          // topSpacerView.setDimension(.height, to: .inset16)
        }
    } else {
      titleView.textContainer.maximumNumberOfLines = 3
      subtitleView.textContainer.maximumNumberOfLines = 6
      thumbView.isHidden = true
      textStackView.layoutMargins = UIEdgeInsets(
        top: .inset12,
        left: .inset16,
        bottom: 0,
        right: .inset16
      )
      // topSpacerView.setDimension(.height, to: .inset16)
    }
    let titleAtributes = CardContent.createNSAttributedString(
      for: model.title,
      font: CardContent.Fonts.title,
      lineHeight: 1.04
    )
    titleAtributes.addAttribute(
      NSAttributedString.Key.foregroundColor,
      value: theme == Theme.light ?
        Styles.Colors.Text.primary :
        Styles.Colors.Text.primaryInverted,
      range: NSRange(location: 0, length: model.title.count)
    )

    titleView.attributedText = titleAtributes

    if hasSubtitle {
      let subtitleAtributes = CardContent.createNSAttributedString(
        for: model.text,
        font: CardContent.Fonts.subtitle,
        lineHeight: 1.1
      )
      subtitleAtributes.addAttribute(
        NSAttributedString.Key.foregroundColor,
        value: theme == Theme.light ?
          Styles.Colors.Text.secondary :
          Styles.Colors.Text.secondaryInverted,
        range: NSRange(location: 0, length: model.text.count)
      )
      subtitleView.attributedText = subtitleAtributes
      subtitleView.isHidden = false

      textStackView.setCustomSpacing(.inset6, after: titleView)
    } else {
      subtitleView.isHidden = true
      textStackView.setCustomSpacing(.inset4, after: titleView)
    }

    setupAdditionalInfoLabel(with: model)

  }
}

extension CardContent {
  private enum Layout {
    static let imageViewBorderWidth: CGFloat = 0.5
    static let titleMaximumNumberOfLines: Int = 2
  }
  enum Fonts {
    static let title = Styles.Fonts.bold(size: .size18)
    static let additionalInfo = Styles.Fonts.regular(size: .size14)
    static let subtitle = Styles.Fonts.regular(size: .size14)
  }

  static func height(with model: CardContentModel) -> CGFloat {
    return textContainerHeight(with: model) + thumbHeight(with: model)
  }

  static func thumbHeight(with model: CardContentModel) -> CGFloat {
    let cardContentInset: CGFloat = Styles.feedCellContentInset * 2
    let thumbWidth: CGFloat =
      model.cellWidth - cardContentInset - Layout.imageViewBorderWidth * 2
    let thumbHeight = thumbWidth * model.thumbAspectRatio

    return thumbHeight
  }

  static private func createNSAttributedString(
    for string: String,
    font: UIFont,
    lineHeight: CGFloat
  ) -> NSMutableAttributedString {
    let style = NSMutableParagraphStyle()
    style.lineHeightMultiple = lineHeight

    return NSMutableAttributedString(string: string, attributes: [
      NSAttributedString.Key.font: font,
      NSAttributedString.Key.paragraphStyle: style
    ])
  }

  static func titleHeight(
    title: String?,
    availableWidth: CGFloat,
    numberOfLines: Int
  ) -> CGFloat {
    guard let title = title else {
      return 0
    }

    let titleNS = self.createNSAttributedString(
      for: title,
      font: CardContent.Fonts.title,
      lineHeight: 1.04
    )
    let titleLines = titleNS.splitByLines(availableWidth: availableWidth)

    let newTitle = NSMutableAttributedString()
    titleLines[..<min(titleLines.count, numberOfLines)].forEach {
      newTitle.append($0)
    }

    return newTitle.height(for: availableWidth)
  }

  static func additionalInfoHeight(
    createDate: String?,
    availableWidth: CGFloat
  ) -> CGFloat {
    guard let createDate = createDate else {
      return 0
    }
    let createDateNS = NSAttributedString(string: createDate, attributes: [
      NSAttributedString.Key.font: CardContent.Fonts.additionalInfo
    ])

    return createDateNS.height(for: availableWidth)
  }

  static func subtitleHeight(
    subtitle: String,
    availableWidth: CGFloat,
    numberOfLines: Int
  ) -> CGFloat {
    if subtitle.isEmpty {
      return 0
    }
    let subtitleNS = self.createNSAttributedString(
      for: subtitle,
      font: CardContent.Fonts.subtitle,
      lineHeight: 1.1
    )
    let subtitleLines = subtitleNS.splitByLines(availableWidth: availableWidth)
    let newSubtitle = NSMutableAttributedString()

    subtitleLines[..<min(subtitleLines.count, numberOfLines)].forEach {
      newSubtitle.append($0)
    }

    return newSubtitle.height(for: availableWidth)
  }

  static func textContainerHeight(with model: CardContentModel) -> CGFloat {
    let hasImage = model.thumbAspectRatio != .zero
    let titleHeight = CardContent.titleHeight(
      title: model.title,
      availableWidth: model.cellContentWidth,
      numberOfLines: hasImage ? 2 : 3
    )
    let subTitleHeight = CardContent.subtitleHeight(
      subtitle: model.text,
      availableWidth: model.cellContentWidth,
      numberOfLines: hasImage ? 3 : 6
    )
    let createDateHeight = CardContent.additionalInfoHeight(
      createDate: model.createDate,
      availableWidth: model.cellContentWidth
    )
    let spacerEndContent: CGFloat = .inset16
    let spacerAfterImage: CGFloat = hasImage ? .inset8 : .inset16

    let spacerBeforeTitle: CGFloat = .inset4
    var spacerAfterTitle: CGFloat = .inset6
    var spacerAfterSubtitle: CGFloat = .inset2

    if model.text.isEmpty {
      spacerAfterTitle = .inset4
      spacerAfterSubtitle = 0
    }

    return titleHeight +
      subTitleHeight +
      createDateHeight +
      spacerBeforeTitle +
      spacerAfterTitle +
      spacerAfterSubtitle +
      spacerEndContent +
      spacerAfterImage
  }
}
