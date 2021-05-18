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
  private let theme = Theme.light
  lazy var collectionTopSpace = Self.defaultCollectionVerticalInset
  lazy var collectionBottomSpace = Self.defaultCollectionVerticalInset
  private var feedProvider: FeedProviding!
  private let refreshControl = UIRefreshControl()
  private var fetchingLink = URL(string: "https://zen.yandex.ru/api/v3/launcher/export")!
  private var footerView: FeedItemFooterCell?

  private var needLoadMore = false

  var cellWidth: CGFloat {
    Styles.feedCellsWidth(for: collectionView)
  }

  init(feedProvider: FeedProviding) {
    super.init(nibName: nil, bundle: nil)
    self.feedProvider = feedProvider
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func loadView() {
    collectionView = makeCollectionView()

    collectionView.refreshControl = refreshControl

    refreshControl.addTarget(self, action: #selector(refreshFeed), for: .valueChanged)

    performSelector(inBackground: #selector(fetchJSON), with: nil)
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    self.collectionView.register(FeedItemCardCell.self)
    self.collectionView.registerFooter(FeedItemFooterCell.self)
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)

    feedProvider.cancel()
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

    let model = models[item.id!] ?? CellMapper().map(
      item: item,
      cellWidth: cellWidth,
      cellContentWidth: cellWidth - textContainerInset,
      theme: theme
    )

    cell.configure(with: model)

    return cell
  }

  @objc func fetchJSON(insertAfter: Bool = false) {
    feedProvider.loadFeed(from: fetchingLink) {
      result in
          switch result {
          case .success(let result):
            self.fetchingLink = result.more.link
            self.updateFeed(items: result.items, insertAfter: insertAfter)
          case .failure(let error):
            DispatchQueue.main.async {
              self.showError(message: error.localizedDescription)}
            }
    }
  }

  private func updateFeed(items: [FeedItem], insertAfter: Bool) {
    let newItems = items.filter {
      guard let cardType = $0.cardType else { return false }
      guard let itemType = $0.itemType else { return false }

      return cardType == zenType && itemType == itemType && !feedItems.contains($0)
    }

    if newItems.isEmpty {
      print("No new Items")
      return
    }

    feedItems = insertAfter ? feedItems + newItems : newItems + feedItems

    DispatchQueue.main.async {
      self.collectionView.reloadData()
    }
  }

  private func showError(message: String) {
    let ac = UIAlertController(title: "Error", message: message, preferredStyle: .alert)

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

  @objc private func refreshFeed(_ sender: Any) {
    DispatchQueue.global(qos: .userInitiated).async {
      self.fetchJSON()

      DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
        self.refreshControl.endRefreshing()
      }
    }
  }

  private func loadMore() {
    guard needLoadMore == false else {
      return
    }

    needLoadMore = true
    
    DispatchQueue.global(qos: .userInitiated).async {
      self.fetchJSON(insertAfter: true)

      DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
        self.footerView?.hideLoader()
        self.needLoadMore = false
      }
    }
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

    models[item.id!] = model
    
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

  override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    if (kind == UICollectionView.elementKindSectionFooter) {
      let result = collectionView.dequeueFooter(FeedItemFooterCell.self, for: indexPath)

      footerView = result

      return result
    }
    fatalError()
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
    if (needLoadMore) {
      return CGSize.zero
    }

    let size = CGSize(width: cellWidth, height: 50)
    return size
  }

  override func scrollViewDidScroll(_ scrollView: UIScrollView) {
    guard let footerView = footerView else {
      return
    }

    let currentOffset = scrollView.contentOffset.y
    let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
    let deltaOffset = maximumOffset - currentOffset

    if deltaOffset <= footerView.frame.size.height && needLoadMore == false  {
      footerView.showLoader()

      loadMore()
    }
  }
}
