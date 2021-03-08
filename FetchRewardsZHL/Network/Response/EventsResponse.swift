//
//  EventsResponse.swift
//  FetchRewardsZHL
//
//  Created by Jeremy on 3/5/21.
//

import Foundation
import ObjectMapper


public class EventsResponse: Response {
    var events: [EventResponse]?
   
    
    public override func mapping(map: Map) {
      events <- map["events"]
    }
}
