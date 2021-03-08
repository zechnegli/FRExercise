//
//  Event.swift
//  FetchRewardsZHL
//
//  Created by Jeremy on 3/7/21.
//

import Foundation
class EventModel{
  var location: String
  var time: String
  var title: String
  var imageURL: String
  var id: Int
  var isLiked: Bool
  
  init(location: String, time: String, title: String, imageURL: String, id: Int, isLiked: Bool) {
    self.location = location
    self.time = time
    self.title = title
    self.imageURL = imageURL
    self.id = id
    self.isLiked = isLiked
  }
}
