//
//  PerformersResponse.swift
//  FetchRewardsZHL
//
//  Created by Jeremy on 3/5/21.
//

import Foundation
import ObjectMapper

class PerformersResponse: Response {
    var performers: [PerformerResponse]?
    
//    override func mapping(map: Map) {
//      performers <- map["performers"]
//    }
}
