///
//  Created by Anna Udobnaja on 30.04.2021.

import UIKit

public protocol AnchorsProviding {
  var leadingAnchor: NSLayoutXAxisAnchor { get }
  var trailingAnchor: NSLayoutXAxisAnchor { get }
  var topAnchor: NSLayoutYAxisAnchor { get }
  var bottomAnchor: NSLayoutYAxisAnchor { get }
  var centerYAnchor: NSLayoutYAxisAnchor { get }
  var centerXAnchor: NSLayoutXAxisAnchor { get }
}

public protocol SizeAnchorProviding {
  var heightAnchor: NSLayoutDimension { get }
  var widthAnchor: NSLayoutDimension { get }
}

extension UIView: AnchorsProviding {}
extension UILayoutGuide: AnchorsProviding {}

extension UIView: SizeAnchorProviding {}

extension UIView {
  public static func newAutoLayout() -> Self {
    let view = self.init()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }
}

private extension SizeAnchorProviding {
  func anchor(for dimension: UIView.LayoutDimension) -> NSLayoutDimension {
    switch dimension {
    case .width:
      return widthAnchor
    case .height:
      return heightAnchor
    }
  }
}

extension UIButton {
  public static func newAutoLayout(type: ButtonType) -> Self {
    let button = self.init(type: type)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }
}
