//
//  DateFormatter.swift
//  FetchRewardsZHL
//
//  Created by Jeremy on 3/6/21.
//

import Foundation
import UIKit
public class DateFormat {
  static let shared = DateFormat()
  
  /// Convert date format from 2021-03-05T09:30:00 to Fri, 02 Oct 2015 \n18:07:00
  /// - Parameter dateString: date string to be converted
  /// - Returns: converted format string
  public static func convertUTCTimeWithNewLine(dateString: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
    
    let dateObj = dateFormatter.date(from: dateString)!
    dateFormatter.dateFormat = "EEEE, dd MMMM yyyy \nh:mm a"
    return dateFormatter.string(from: dateObj)
    
  }
  
  /// Convert date format from 2021-03-05T09:30:00 to Fri, 02 Oct 2015 18:07:00
  /// - Parameter dateString: date string to be converted
  /// - Returns: converted format string
  public static func convertUTCTime(dateString: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
    
    let dateObj = dateFormatter.date(from: dateString)!
    dateFormatter.dateFormat = "EEEE, dd MMMM yyyy h:mm a"
    return dateFormatter.string(from: dateObj)
    
  }
  
  
  
}
