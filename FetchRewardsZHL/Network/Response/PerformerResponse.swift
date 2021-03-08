//
//  PerformerResponse.swift
//  FetchRewardsZHL
//
//  Created by Jeremy on 3/5/21.
//

import Foundation
import ObjectMapper

public class PerformerResponse: Response {
    var imageURL: String?
    
    public override func mapping(map: Map) {
      imageURL <- map["image"]
    }
}
