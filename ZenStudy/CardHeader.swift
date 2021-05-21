///
// Created by Anna Udobnaja on 05.05.2021.

import UIKit

class CardHeader: UIView {
  lazy var stackView = makeStackView()
  lazy var menuButton = makeMenuButton()
  lazy var publisherContainerView = makePublisherContainer()
  lazy var publisherInfoView = makePublisherInfo()
  lazy var publisherAvatar = makePublisherAvatar()
  lazy var publisherTitle = makePublisherTitle()
  lazy var subscribedLabel = makeSubscribedLabel()

  override init(frame: CGRect) {
    super.init(frame: frame)

    setupLayout()

    configureViewActions()
  }

  required init?(coder: NSCoder) {
    fatalError("Init(coder:) has not been implemented")
  }

  private func setupLayout() {
    setDimension(.height, to: Layout.height)

    addSubview(stackView)

    stackView.pinEdgesToSuperview()
    stackView.isLayoutMarginsRelativeArrangement = true
    stackView.layoutMargins = UIEdgeInsets(
      top: .inset10,
      left: .inset16,
      bottom: .inset10,
      right: .inset16
    )

    stackView.addArrangedSubview(publisherContainerView)
    stackView.addArrangedSubview(menuButton)

    publisherContainerView.addArrangedSubview(publisherAvatar)
    publisherContainerView.addArrangedSubview(publisherInfoView)

    publisherInfoView.addArrangedSubview(publisherTitle)
    publisherInfoView.addArrangedSubview(subscribedLabel)
  }

  private func configureViewActions() {
    let handleChannelTap = UITapGestureRecognizer(
      target: self,
      action: #selector(handleChannelButtonTap)
    )

    publisherContainerView.addGestureRecognizer(handleChannelTap)

    menuButton.addTarget(
      self,
      action: #selector(handleMenuButtonTap),
      for: .touchUpInside
    )
  }
  @objc func handleChannelButtonTap(_ sender: UIStackView) {
    print("click to channel button")
  }

  @objc private func handleMenuButtonTap(_ sender: UIButton) {
    print("click to menu button")
  }

  private func makeStackView() -> UIStackView {
    let stackView = UIStackView.newAutoLayout()

    stackView.axis = .horizontal
    stackView.alignment = .center
    stackView.distribution = .equalSpacing

    stackView.spacing = .inset8

    return stackView
  }

  private func makePublisherInfo() -> UIStackView {
    let stackView = UIStackView.newAutoLayout()

    stackView.axis = .vertical
    stackView.alignment = .leading
    stackView.distribution = .equalSpacing

    stackView.spacing = .inset2

    return stackView
  }

  private func makeMenuButton() -> UIButton {
    let button = UIButton.newAutoLayout()

    return button
  }

  private func makePublisherTitle() -> UITextView {
    let title = UITextView.newAutoLayout()

    title.font = Styles.Fonts.regular(size: .size14)
    title.backgroundColor = .clear
    title.clipsToBounds = true
    title.isEditable = false
    title.isScrollEnabled = false
    title.isSelectable = false
    title.isUserInteractionEnabled = false
    title.textContainer.lineBreakMode = .byTruncatingTail
    title.textContainer.lineFragmentPadding = 0
    title.textContainerInset = .zero

    return title
  }

  private func makePublisherContainer() -> UIStackView {
    return makeStackView()
  }

  private func makePublisherAvatar() -> UIImageView {
    let imageView = UIImageView.newAutoLayout()

    imageView.contentMode = .scaleAspectFill
    imageView.layer.cornerRadius = Layout.avatarSize / 2
    imageView.image = UIImage(named: Assets.placeholderAvatar)
    imageView.clipsToBounds = true

    imageView.setDimensions(
      to: CGSize(width: Layout.avatarSize, height: Layout.avatarSize)
    )

    let fadeView = UIView.newAutoLayout()
    fadeView.backgroundColor = Styles.Colors.Other.avatarsFade
    imageView.addSubview(fadeView)

    fadeView.pinEdgesToSuperview()

    return imageView
  }

  private func makeSubscribedLabel() -> UILabel {
    let label = UILabel.newAutoLayout()
    label.numberOfLines = 1
    label.font = Styles.Fonts.regular(size: .size13)

    return label
  }

  private func setupTheme(theme: Theme) {
    switch theme {
    case .light:
      publisherTitle.textColor = Styles.Colors.Text.primary
      subscribedLabel.textColor = Styles.Colors.Text.tetriary
      menuButton.setImage(UIImage(named: Assets.menu), for: .normal)
    case .dark:
      publisherTitle.textColor = Styles.Colors.Text.primaryInverted
      subscribedLabel.textColor = Styles.Colors.Text.tetriaryInverted
      menuButton.setImage(UIImage(named: Assets.menuDark), for: .normal)
    }
  }

  func configure(
    with model: CardHeaderModel,
    theme: Theme
  ) {

    setupTheme(theme: theme)

    if let imageSrc = model.avatarSrc {
        if let url = URL(string: imageSrc) {
          publisherAvatar.load(url: url)
        }
    }

    publisherTitle.text = model.title

    if model.isSubscribed {
      subscribedLabel.text = "Вы подписаны"
      subscribedLabel.isHidden = false
    } else {
      subscribedLabel.isHidden = true
    }

  }

}

extension CardHeader {
  private enum Layout {
    static let height: CGFloat = 56
    static let avatarSize: CGFloat = 36
  }
}

extension CardHeader {
  static func height() -> CGFloat {
    Layout.height
  }
}
