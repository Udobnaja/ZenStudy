//
//  Feed.swift
//  ZenStudy
//
//  Created by Anna Udobnaja on 29.04.2021.
//

import UIKit

private let zenType = "zen"
private let itemType = "native"

class FeedController: UICollectionViewController {
  static let defaultCollectionVerticalInset: CGFloat = 6

  private(set) var feedItems = [FeedItem]()
  private var models = [String: CellModel]()
  private let theme = Theme.dark
  lazy var collectionTopSpace = Self.defaultCollectionVerticalInset
  lazy var collectionBottomSpace = Self.defaultCollectionVerticalInset

  var cellWidth: CGFloat {
    Styles.feedCellsWidth(for: collectionView)
  }

  override func loadView() {
    collectionView = makeCollectionView()

    performSelector(inBackground: #selector(fetchJSON), with: nil)
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    self.collectionView.register(FeedItemCardCell.self)
  }

  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }

  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return feedItems.count
  }

  

  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeue(FeedItemCardCell.self, for: indexPath)

    let item = feedItems[indexPath.item]

    let cardContentInset: CGFloat = .inset8
    let textContainerInset: CGFloat = cardContentInset + .inset16 * 2

    let model = models[item.id] ?? CellMapper().map(
      item: item,
      cellWidth: cellWidth,
      cellContentWidth: cellWidth - textContainerInset,
      theme: theme
    )

    cell.configure(with: model)

    return cell
  }

  @objc func fetchJSON() {
    if let url = Bundle.main.url(forResource: "predefined_feed_response", withExtension: "json") {
      if let data = try? Data(contentsOf: url) {
        parse(json: data)

        return
      }
    }

    showError()
  }

  private func parse(json: Data) {
    let decoder = JSONDecoder()

    if let result = try? decoder.decode(FeedItems.self, from: json) {
      feedItems = result.items.filter {
        guard let cardType = $0.cardType else { return false }
        guard let itemType = $0.itemType else { return false }

        return cardType == zenType && itemType == itemType
      }

      DispatchQueue.main.async {
        self.collectionView.reloadData()
      }

      return
    }

    DispatchQueue.main.async {
      self.showError()
    }

  }

  private func showError() {
    let ac = UIAlertController(title: "Error", message: nil, preferredStyle: .alert)

    ac.addAction(UIAlertAction(title: "OK", style: .default))

    present(ac, animated: true)
  }

  private func makeCollectionView() -> UICollectionView {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    layout.minimumLineSpacing = 6
    layout.estimatedItemSize = .zero

    let collectionView =
      UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.showsVerticalScrollIndicator = false
    collectionView.showsHorizontalScrollIndicator = false

    collectionView.delegate = self
    collectionView.dataSource = self

    let color = theme == .light ? Styles.Colors.Background.feed : Styles.Colors.Background.feedInverted
    collectionView.backgroundColor = color

    return collectionView
  }
}

extension FeedController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let item = feedItems[indexPath.item]

    let cardContentInset: CGFloat = Styles.feedCellContentInset * 3
    let textContainerInset: CGFloat = cardContentInset + .inset16 * 2

    let model = CellMapper().map(
      item: item,
      cellWidth: cellWidth,
      cellContentWidth: cellWidth - textContainerInset,
      theme: theme
    )

    models[item.id] = model
    
    let height = FeedItemCardCell.height(with: model, for: item)

    return CGSize(width: cellWidth, height: height)
  }

  func collectionView(
    _ collectionView: UICollectionView,
    layout _: UICollectionViewLayout,
    insetForSectionAt _: Int
  ) -> UIEdgeInsets {
    let sideInset = Styles.feedCellSideInset(for: collectionView)
    return
      UIEdgeInsets(
        top: collectionTopSpace,
        left: sideInset,
        bottom: collectionBottomSpace,
        right: sideInset
      )
  }
}
