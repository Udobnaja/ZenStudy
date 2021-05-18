// Copyright 2021 Yandex LLC. All rights reserved.

import UIKit

public extension UIColor {
  convenience init?(hex: String) {
    let red, green, blue, alpha: CGFloat

    if hex.hasPrefix("#") {
      let start = hex.index(hex.startIndex, offsetBy: 1)
      let hexColor = String(hex[start...])

      if hexColor.count == 8 {
        let scanner = Scanner(string: hexColor)
        var hexNumber: UInt64 = 0

        if scanner.scanHexInt64(&hexNumber) {
          red = CGFloat((hexNumber & 0xFF_00_00_00) >> 24) / 255
          green = CGFloat((hexNumber & 0x00_FF_00_00) >> 16) / 255
          blue = CGFloat((hexNumber & 0x00_00_FF_00) >> 8) / 255
          alpha = CGFloat(hexNumber & 0x00_00_00_FF) / 255

          self.init(red: red, green: green, blue: blue, alpha: alpha)
          return
        }
      } else if hexColor.count == 6 {
        let scanner = Scanner(string: hexColor)
        var hexNumber: UInt64 = 0

        if scanner.scanHexInt64(&hexNumber) {
          red = CGFloat((hexNumber & 0xFF_00_00) >> 16) / 255
          green = CGFloat((hexNumber & 0x00_FF_00) >> 8) / 255
          blue = CGFloat((hexNumber & 0x00_00_FF) >> 0) / 255
          alpha = 1

          self.init(red: red, green: green, blue: blue, alpha: alpha)
          return
        }
      }
    }
    return nil
  }
}

