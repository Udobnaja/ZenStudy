//
//  CardFooter.swift
//  ZenStudy
//
//  Created by Anna Udobnaja on 30.04.2021.
//

import UIKit

class CardFooter: UIView {
  private lazy var containertView = makeStackView()
  private lazy var controlsStackView = makeStackView()
  private lazy var commentsStackView = makeStackView()
  
  private lazy var shareBtn = makeButton()
  private lazy var likeBtn = makeButton()
  private lazy var dislikeBtn = makeButton()

  private lazy var bigAvatar = makeCommentsAvatar()
  private lazy var smallAvatar = makeCommentsAvatar()
  private lazy var commentsCountLabel = makeCommentsCountLabel()

  private var reaction: Reaction = .empty
  private var theme: Theme!

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

    addSubview(containertView)

    containertView.distribution = .equalSpacing

    containertView.pinEdgesToSuperview()
    containertView.isLayoutMarginsRelativeArrangement = true
    containertView.layoutMargins = UIEdgeInsets(top: .inset8, left: .inset16, bottom: .inset12, right: .inset16)

    containertView.addArrangedSubview(commentsStackView)
    containertView.addArrangedSubview(controlsStackView)

    commentsStackView.addArrangedSubview(bigAvatar)
    commentsStackView.addArrangedSubview(smallAvatar)
    commentsStackView.addArrangedSubview(commentsCountLabel)

    commentsStackView.sendSubviewToBack(smallAvatar)
    commentsStackView.setCustomSpacing(-.inset12, after: bigAvatar)
    commentsStackView.setCustomSpacing(.inset8, after: smallAvatar)

    let buttons = [shareBtn, likeBtn, dislikeBtn]

    for button in buttons {
      controlsStackView.addArrangedSubview(button)
    }
  }

  private func configureViewActions() {
    shareBtn.addTarget(
      self,
      action: #selector(handleShareButtonTap),
      for: .touchUpInside
    )

    dislikeBtn.addTarget(
      self,
      action: #selector(handleDislikeButtonTap),
      for: .touchUpInside
    )

    likeBtn.addTarget(
      self,
      action: #selector(handleLikeButtonTap),
      for: .touchUpInside
    )

    let handleCommentsTap = UITapGestureRecognizer(target: self, action: #selector(handleCommentsButtonTap))

    commentsStackView.addGestureRecognizer(handleCommentsTap)
  }

  @objc private func handleShareButtonTap(_ sender: UIButton) {
    print("click to share BTN")
  }

  @objc private func handleDislikeButtonTap(_ sender: UIButton) {
    print("click to dislike BTN")

    if reaction == .dislike {
      reaction = .empty
    } else {
      reaction = .dislike
    }

    updateReactionButtons(with: reaction)
  }

  @objc private func handleLikeButtonTap(_ sender: UIButton) {
    print("click to like BTN")

    if reaction == .like {
      reaction = .empty
    } else {
      reaction = .like
    }
    updateReactionButtons(with: reaction)
  }

  @objc private func handleCommentsButtonTap(_ sender: UIStackView) {
    print("click to comments area")
  }

  private func updateReactionButtons(with reaction: Reaction) {
    var likeImage = ""
    var dislikeImage = ""
    switch reaction {
      case .like:
        switch theme {
          case .dark:
            likeImage = Assets.likeDarkFilled
            dislikeImage = Assets.dislikeDark
          default:
            likeImage = Assets.likeFilled
            dislikeImage = Assets.dislike
        }

      case .dislike:
        switch theme {
          case .dark:
            likeImage = Assets.likeDark
            dislikeImage = Assets.dislikeDarkFilled
          default:
            likeImage = Assets.like
            dislikeImage = Assets.dislikeFilled
        }

      case .empty:
        switch theme {
          case .dark:
            likeImage = Assets.likeDark
            dislikeImage = Assets.dislikeDark
          default:
            likeImage = Assets.like
            dislikeImage = Assets.dislike
        }
      }

    likeBtn.setImage(UIImage(named: likeImage), for: .normal)
    dislikeBtn.setImage(UIImage(named: dislikeImage), for: .normal)
  }

  private func makeStackView() -> UIStackView {
    let stackView = UIStackView.newAutoLayout()

    stackView.axis = .horizontal
    stackView.alignment = .center

    stackView.spacing = .inset8

    return stackView
  }

  private func makeButton() -> UIButton {
    let button = UIButton.newAutoLayout()

    button.setDimensions(to: CGSize(width: 32, height: 32))

    return button
  }

  private func makeCommentsAvatar() -> UIImageView {
    let imageView = UIImageView.newAutoLayout()

    imageView.contentMode = .scaleAspectFill
    let avatarSize = Layout.avatarSize + Layout.avatarBorderSize * 2

    imageView.layer.borderWidth = Layout.avatarBorderSize

    imageView.layer.cornerRadius = avatarSize / 2
    imageView.image = UIImage(named: Assets.placeholderAvatar)
    imageView.clipsToBounds = true

    imageView.setDimensions(to: CGSize(width: avatarSize, height: avatarSize))

    let fadeView = UIView.newAutoLayout()
    fadeView.backgroundColor = Styles.Colors.Other.avatarsFade
    imageView.addSubview(fadeView)

    fadeView.pinEdgesToSuperview()

    return imageView
  }

  private func makeCommentsCountLabel() -> UILabel {
    let label = UILabel.newAutoLayout()
    label.numberOfLines = 1
    label.lineBreakMode = .byTruncatingTail
    label.font = Styles.Fonts.regular(size: .size14)

    return label
  }

  private func makeCommentsLabelStub(theme: Theme) {
    let color = theme == .light ? Styles.Colors.Text.secondary : Styles.Colors.Text.secondaryInverted

    let commentsAttributedString =
      NSAttributedString(
        string: "Комментариев",
        attributes: [
          .font: Styles.Fonts.regular(size: .size14),
          .foregroundColor: color,
        ]
      )
    let numberAttributedString =
      NSAttributedString(
        string: "256 ",
        attributes: [
          .font: Styles.Fonts.bold(size: .size14),
          .foregroundColor: color,
        ]
      )
    let resultString =
      NSMutableAttributedString(attributedString: numberAttributedString)
    resultString.append(commentsAttributedString)

    commentsCountLabel.attributedText = resultString
  }

  private func setupTheme(theme: Theme) {
    self.theme = theme

    switch theme {
      case .light:
        commentsCountLabel.textColor = Styles.Colors.Text.secondary
        bigAvatar.layer.borderColor = Styles.Colors.Background.primary.cgColor
        smallAvatar.layer.borderColor = Styles.Colors.Background.primary.cgColor
        shareBtn.setImage(UIImage(named: Assets.shareArrow), for: .normal)
        likeBtn.setImage(UIImage(named: Assets.like), for: .normal)
        dislikeBtn.setImage(UIImage(named: Assets.dislike), for: .normal)
      case .dark:
        commentsCountLabel.textColor = Styles.Colors.Text.secondaryInverted
        bigAvatar.layer.borderColor = Styles.Colors.Background.primaryInverted.cgColor
        smallAvatar.layer.borderColor = Styles.Colors.Background.primaryInverted.cgColor
        shareBtn.setImage(UIImage(named: Assets.shareArrowDark), for: .normal)
        likeBtn.setImage(UIImage(named: Assets.likeDark), for: .normal)
        dislikeBtn.setImage(UIImage(named: Assets.dislikeDark), for: .normal)
      }
  }

  func configure(
    theme: Theme
  ){
    setupTheme(theme: theme)

    makeCommentsLabelStub(theme: theme)
  }

}

extension CardFooter {
  private enum Layout {
    static let height: CGFloat = 52
    static let avatarSize: CGFloat = 24
    static let avatarBorderSize: CGFloat = 2
  }
}


extension CardFooter {
  static func height() -> CGFloat {
    Layout.height
  }
}
