//
//  UsersManager.swift
//  FetchRewardsZHL
//
//  Created by Jeremy on 03/05/21.
//  Copyright © 2021 FetchRewardsZHL. All rights reserved.
//

import Foundation

public class EventsManager: DataManager {
    func getAllEvents(callback: @escaping ( _ response: EventsResponse?,  _ error: Error?) -> Void) {
        doGet(Endpoints.events.stringValue, params: ["client_id" : userID], callback: callback)

        }
}
