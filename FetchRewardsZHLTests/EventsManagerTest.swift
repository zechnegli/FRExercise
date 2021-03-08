//
//  EventsManagerTest.swift
//  FetchRewardsZHLTests
//
//  Created by Jeremy on 3/7/21.
//

import XCTest
@testable import FetchRewardsZHL
import UIKit

class EventsManagerTest: XCTestCase {
  var sut: EventsManager!
  override func setUp() {
    super.setUp()
    sut = EventsManager()
  }

  func testConvertedTime() {
    let expectation = self.expectation(description: "Get new events")
    var responseError: Error? = nil
    sut.getAllEvents { (response, error) in
      responseError = error
      expectation.fulfill()
      
      
    }
    waitForExpectations(timeout: 300)
    XCTAssert(responseError == nil)
  }
  
  

}
