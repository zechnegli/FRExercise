//
//  DateFormatTest.swift
//  FetchRewardsZHLTests
//
//  Created by Jeremy on 3/7/21.
//

import XCTest
@testable import FetchRewardsZHL
import UIKit

class DateFormatTest: XCTestCase {

  override func setUp() {
    super.setUp()
  }

  func testConvertedTime() {
    //1
    let exptectedTime = "Friday, 05 March 2021 9:30 AM"
    
    //2
    let result = DateFormat.convertUTCTime(dateString: "2021-03-05T09:30:00")
    
    //3
    XCTAssertTrue(exptectedTime == result)
    
  }
  
  

}
