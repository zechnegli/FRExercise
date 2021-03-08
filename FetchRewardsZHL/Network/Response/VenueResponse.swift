//
//  VenueResponse.swift
//  FetchRewardsZHL
//
//  Created by Jeremy on 3/5/21.
//

import Foundation
import ObjectMapper


public class VenueResponse: Response {
    var location: String?
    
  public override func mapping(map: Map) {
        location <- map["display_location"]
    }
}
