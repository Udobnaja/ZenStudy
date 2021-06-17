///
//  Created by Anna Udobnaja on 30.04.2021.

import UIKit

public extension Styles {
  enum Colors {

  }
}

public extension Styles.Colors {
  enum Text {
    public static let primary = UIColor.hex("#000000")
    public static let secondary = UIColor.hex("#000000", alpha: 0.8)
    public static let tetriary = UIColor.hex("#000000", alpha: 0.5)
    public static let quaternary = UIColor.hex("#000000", alpha: 0.3)
    public static let quinary = UIColor.hex("#000000", alpha: 0.16)
    public static let primaryInverted = UIColor.hex("#FFFFFF", alpha: 0.8)
    public static let secondaryInverted = UIColor.hex("#FFFFFF", alpha: 0.6)
    public static let tetriaryInverted = UIColor.hex("#FFFFFF", alpha: 0.45)
    public static let quaternaryInverted = UIColor.hex("#FFFFFF", alpha: 0.3)
    public static let quinaryInverted = UIColor.hex("#FFFFFF", alpha: 0.16)
    public static let defaultPriceDark = UIColor.hex("#FFFFFF", alpha: 0.8)
    public static let discountPriceLight = UIColor.hex("#FF3333")
    public static let discountPriceDark = UIColor.hex("#FB5C56")
    public static let previousPriceDark = UIColor.hex("#FFFFFF", alpha: 0.45)
    public static let productsGallerySingleTitleDark =
      UIColor.hex("#FFFFFF", alpha: 0.6)
    public static let productsGalleryMultipleTitleDark =
      UIColor.hex("#FFFFFF", alpha: 0.8)
  }

  enum Background {
    public static let primary = UIColor.hex("#FFFFFF")
    public static let secondary = UIColor.hex("#F0F1F5")
    public static let tetriary = UIColor.hex("#E7E9EF")
    public static let quaternary = UIColor.hex("#D0D1D9")
    public static let primaryInverted = UIColor.hex("#111215")
    public static let secondaryInverted = UIColor.hex("#1D1E22")
    public static let feed = UIColor.hex("#F0F1F5")
    public static let feedInverted = UIColor.hex("#000000")
    public static let productsGalleryCardDark = UIColor.hex("#2E2F34")
    public static let priceStubLight = UIColor.hex("#333333", alpha: 0.08)
    public static let priceStubDark = UIColor.hex("#FFFFFF", alpha: 0.08)
    public static let clickToWatchWithSound = UIColor.hex("#333333", alpha: 0.85)
  }

  enum Fade {
    public static let regular = UIColor.hex("#000000", alpha: 0.5)
    public static let light = UIColor.hex("#000000", alpha: 0.3)
  }

  enum Accent {
    public static let yellow = UIColor.hex("#FFCC00")
    public static let blue = UIColor.hex("#0077FF")
    public static let blueInverted = UIColor.hex("#80BBFF")
    public static let red = UIColor.hex("#FF0000")
    public static let green = UIColor.hex("#00B341")
  }

  enum Brand {
    public static let anthracite = UIColor.hex("#252630")
    public static let amaranth = UIColor.hex("#E7403E")
  }

  enum Other {
    public static let avatarsFade = UIColor.hex("#333333", alpha: 0.05)
    public static let imageBorder = UIColor.hex("#000000", alpha: 0.12)
    public static let stubsColor = UIColor.hex("#F2F2F2")
    public static let shadowColor = UIColor.hex("#0D142E")
    public static let videoControlsBackground =
      UIColor.hex("#000000", alpha: 0.2)
    public static let separator = UIColor.hex("#000000", alpha: 0.2)
  }

  enum NoImageAdCardBackground {
    public static let option1 = [UIColor.hex("#E22049"), UIColor.hex("#EC6133")]
    public static let option2 = [UIColor.hex("#5037DC"), UIColor.hex("#2574FA")]
    public static let option3 = [UIColor.hex("#3778E5")]
    public static let option4 = [UIColor.hex("#DF5835")]
    public static let option5 = [UIColor.hex("#4841DD")]

    public static let all = [option1, option2, option3, option4, option5]
  }
}

private extension UIColor {
  static func hex(_ string: String, alpha: CGFloat = 1) -> UIColor {
    guard let color = UIColor(hex: string) else {
      assertionFailure("Unable to initialize UIColor from hex '\(string)'")
      return UIColor.clear
    }

    return color.withAlphaComponent(alpha)
  }
}
