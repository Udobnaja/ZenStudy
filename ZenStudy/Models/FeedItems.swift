//
//  FeedItems.swift
//  ZenStudy
//
//  Created by Anna Udobnaja on 29.04.2021.
//
import UIKit

struct FeedItems: Codable {
  var items: [FeedItem]
  var more: FeedLink
}

struct FeedLink: Codable {
  var link: URL
}
