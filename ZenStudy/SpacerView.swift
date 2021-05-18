//
//  SpacerView.swift
//  ZenStudy
//
//  Created by Anna Udobnaja on 04.05.2021.
//

import UIKit

public class SpacerView: UIView {
  public static var height4: SpacerView {
    SpacerView(height: .height4)
  }

  public static var height8: SpacerView {
    SpacerView(height: .height8)
  }

  public static var height12: SpacerView {
    SpacerView(height: .height12)
  }

  public static var height14: SpacerView {
    SpacerView(height: .height14)
  }

  public static var height16: SpacerView {
    SpacerView(height: .height16)
  }

  public static var height24: SpacerView {
    SpacerView(height: .height24)
  }

  public static var height32: SpacerView {
    SpacerView(height: .height32)
  }

  public static var feedLineSpacer: SpacerView {
    SpacerView(height: .feedLineSpacer)
  }

  public init(height: Height) {
    super.init(frame: .zero)
    self.translatesAutoresizingMaskIntoConstraints = false
    setDimension(.height, to: height.value)
  }

  required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - Height

public extension SpacerView {
  enum Height {
    case height4
    case height8
    case height12
    case height14
    case height16
    case height24
    case height32
    case feedLineSpacer

    public var value: CGFloat {
      switch self {
      case .height4: return 4
      case .height8: return 8
      case .height12: return 12
      case .height14: return 14
      case .height16: return 16
      case .height24: return 24
      case .height32: return 32
      case .feedLineSpacer: return Styles.feedCellsLineSpacing
      }
    }
  }
}
