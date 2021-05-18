//
//  Styles+Font.swift
//  ZenStudy
//
//  Created by Anna Udobnaja on 13.05.2021.
//

import UIKit

public extension Styles {
  enum Fonts {
    public static func medium(size: Size) -> UIFont {
      return Styles.Fonts.getFont(size: size, typeface: .medium)
    }

    public static func regular(size: Size) -> UIFont {
      return Styles.Fonts.getFont(size: size, typeface: .regular)
    }

    public static func bold(size: Size) -> UIFont {
      return Styles.Fonts.getFont(size: size, typeface: .bold)
    }

    private static func getFont(size: Size, typeface: Typeface) -> UIFont {
      return UIFont(name: "YSText-\(typeface.rawValue)", size: size.rawValue) ?? UIFont.systemFont(ofSize: size.rawValue)
    }
  }
}

public extension Styles.Fonts {
  enum Size: CGFloat {
    case size10 = 10
    case size11 = 11
    case size12 = 12
    case size13 = 13
    case size14 = 14
    case size16 = 16
    case size18 = 18
    case size20 = 20
    case size22 = 22
    case size24 = 24
    case size25 = 25
    case size28 = 28
    case size40 = 40
  }
}

public extension Styles.Fonts {
  enum Typeface: String {
    case regular = "Regular"
    case bold = "Bold"
    case medium = "Medium"
  }
}
