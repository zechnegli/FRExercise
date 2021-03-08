//
//  UserResponse.swift
//  FetchRewardsZHL
//
//  Created by Jeremy on 03/05/21.
//  Copyright © 2021 FetchRewardsZHL. All rights reserved.
//

import Foundation
import ObjectMapper


public class EventResponse: Response {
  var venue: VenueResponse?
  var time: String?
  var title: String?
  var performers: [PerformerResponse]?
  var id: Int?

  public override func mapping(map: Map) {
    title <- map["short_title"]
    venue <- map["venue"]
    time <- map["datetime_utc"]
    performers <- map["performers"]
    id <- map["id"]
  }
}
//events->venue->display_location
//events-> "datetime_utc"
//events-> short_title
//events->performers->image
