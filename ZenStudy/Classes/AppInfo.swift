///
//  Created by Anna Udobnaja on 21.05.2021.

import Foundation
import UIKit

class AppInfo {
  static let appVersion = getAppVersion()
  static let bundleID = Bundle.main.bundleIdentifier
  static let userAgent = constructUserAgentString()
//  static let bundleVersion = getBundleVersion()
//  static let zenKitXVersionString = "IZenKit/\(ZenManager.version)"

  private static func getAppVersion() -> String {
    let bundle = Bundle.main
    let appVersionKey = "CFBundleShortVersionString"
    let shortVersionString =
      bundle.object(forInfoDictionaryKey: appVersionKey) as? String
    return shortVersionString ?? "0"
  }
//
//  private static func getBundleVersion() -> String {
//    let bundle = Bundle.main
//    let bundleVersionKey = "CFBundleVersion"
//    let bundleVersionString =
//      bundle.object(forInfoDictionaryKey: bundleVersionKey) as? String
//    return bundleVersionString ?? "0"
//  }

  private static func constructUserAgentString() -> String {
      let currentDevice = UIDevice.current
      let iOSVersion =
        currentDevice.systemVersion.replacingOccurrences(
          of: ".",
          with: "_",
          options: .literal,
          range: nil
        )
      let isIPad = currentDevice.userInterfaceIdiom == .pad
      let deviceType = isIPad ? "iPad" : "iPhone"

      let appString =
        "Mozilla/5.0 (\(deviceType); " +
        "CPU \(!isIPad ? deviceType : "") " +
        "OS \(iOSVersion) like Mac OS X)"

      return "\(appString)"
    }

//  private static func constructUserAgentString() -> String {
//    let buildTypeRegexPattern = "(.inhouse)|(.dev)|(.beta)"
//    guard let buildTypeRegex =
//      try? NSRegularExpression(
//        pattern: buildTypeRegexPattern,
//        options: NSRegularExpression.Options.caseInsensitive
//      )
//    else {
//      assertionFailure("Failed to get build type")
//      return ""
//    }
//    let bundleID = self.bundleID ?? ""
//    let range = NSRange(location: 0, length: bundleID.count)
//    let cleanedBundleId =
//      buildTypeRegex.stringByReplacingMatches(
//        in: bundleID,
//        options: [],
//        range: range,
//        withTemplate: ""
//      )
//
//    let currentDevice = UIDevice.current
//    let bundleString = "\(cleanedBundleId)/\(appVersion)"
//    let iOSVersion =
//      currentDevice.systemVersion.replacingOccurrences(
//        of: ".",
//        with: "_",
//        options: .literal,
//        range: nil
//      )
//    let isIPad = currentDevice.userInterfaceIdiom == .pad
//    let deviceType = isIPad ? "iPad" : "iPhone"
//
//    let appString =
//      "Mozilla/5.0 (\(deviceType); " +
//      "CPU \(!isIPad ? deviceType : "") " +
//      "OS \(iOSVersion) like Mac OS X)"
//
//    return "\(bundleString) \(appString)"
//  }
}
