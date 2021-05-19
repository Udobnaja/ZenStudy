//
//  FeedItemFooterCell.swift
//  ZenStudy
//
//  Created by Anna Udobnaja on 18.05.2021.
//

import UIKit

class FeedItemFooterCell: UICollectionReusableView {
  lazy var loaderView = makeLoaderView()

  override init(frame: CGRect) {
    super.init(frame: frame)

    isHidden = true

    addSubview(loaderView)

    loaderView.pinEdgesToSuperview()
  }

  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)!
  }

  private func makeLoaderView() -> UIActivityIndicatorView {
    let result = UIActivityIndicatorView.newAutoLayout()

    result.hidesWhenStopped = true
    result.style = UIActivityIndicatorView.Style.medium

    return result
  }

  func configure(theme: Theme) {
    loaderView.color = theme == Theme.light ? Styles.Colors.Text.primary : Styles.Colors.Text.primaryInverted
  }

  func  showLoader(){
    isHidden = false
    loaderView.startAnimating()
  }

  func  hideLoader(){
    isHidden = true
    loaderView.stopAnimating()
  }
}

