//
//  Endpoints.swift
//  FetchRewardsZHL
//
//  Created by Jeremy on 03/05/21.
//  Copyright © 2021 FetchRewardsZHL. All rights reserved.
//

import Foundation

enum Endpoints {
    static let TeeTalkbase = "https://api.seatgeek.com/2"
    case events
    
    
    var stringValue: String {
        switch self {
            case .events:
              return Endpoints.TeeTalkbase + "/events"
        }
    }
    
    var url: URL {
        return URL(string: stringValue)!
    }
    
}
