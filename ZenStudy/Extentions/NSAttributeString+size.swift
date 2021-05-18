//
//  NSAttributeString+size.swift
//  ZenStudy
//
//  Created by Anna Udobnaja on 06.05.2021.
//

import CoreGraphics
import CoreText
import Foundation

public extension NSAttributedString {
  func height(for width: CGFloat) -> CGFloat {
    let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
    let boundingBox =
      boundingRect(
        with: constraintRect,
        options: .usesLineFragmentOrigin,
        context: nil
      )

    return ceil(boundingBox.height)
  }

  func width(for height: CGFloat) -> CGFloat {
    let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
    let boundingBox =
      boundingRect(
        with: constraintRect,
        options: .usesLineFragmentOrigin,
        context: nil
      )

    return ceil(boundingBox.width)
  }

  func splitByLines(availableWidth: CGFloat) -> [NSAttributedString] {
    let framesetter = CTFramesetterCreateWithAttributedString(self)
    let rect =
      CGRect(x: 0, y: 0, width: availableWidth, height: .greatestFiniteMagnitude)
    let path = CGPath(rect: rect, transform: nil)
    let ctFrame =
      CTFramesetterCreateFrame(
        framesetter,
        .init(location: 0, length: 0),
        path,
        nil
      )

    guard let lines = CTFrameGetLines(ctFrame) as? [Any] else {
      return []
    }

    var result = [NSAttributedString]()
    for ctLine in lines {
      // swiftlint:disable:next force_cast
      let line = ctLine as! CTLine
      let lineRange = CTLineGetStringRange(line)
      let range = NSRange(location: lineRange.location, length: lineRange.length)
      let lineString = attributedSubstring(from: range)
      result.append(lineString)
    }

    return result
  }

}
