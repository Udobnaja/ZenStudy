///
//  Created by Anna Udobnaja on 21.05.2021.

import UIKit

import ZenCore

class FeaturesProvider: SupportedFeaturesProviding {

  var supportedFeatures: SupportedFeatures {
    SupportedFeatures(
      screens: ["feed"],
      card_types: [
        "card"
      ],
      auth_header: true,
      screenDPI: Int(UIScreen.main.scale * 160),
      need_background_image: true,
      forced_bulk_stats: true,
      no_small_auth: true,
      interests_supported: true,
      promo_label: true,
      blurred_preview: true,
      ad_providers: ["direct"],
      ad_formats: ["single", "multi"],
      theme: "light",
      feed_type: "card",
      preset_number: 1,
      disabled_yandex_block_ids: Set<String>()
    )
  }
}
