//
//  DataManager.swift
//  FetchRewardsZHL
//
//  Created by Jeremy on 03/05/21.
//  Copyright © 2021 FetchRewardsZHL. All rights reserved.
//

import Foundation
import ObjectMapper
import Alamofire

public class DataManager {
    /// General get method
    /// - Parameters:
    ///   - fullPath: URL including the base url
    ///   - params:   Custom key-value pair parameters for http body
    ///   - callback: Completion handler with specific type of result and error
     func doGet<T: Mappable>(_ fullPath: String, params: [String: Any], callback: @escaping (_ result: T?,_ error: Error?) -> Void) {
        doMethod(fullPath, httpMethod: .get, encoding: Alamofire.JSONEncoding.default, params: params, callback: callback)
    }

    
    
    ///General method to set  up response error  or response result after sending a request
       /// - Parameters:
       ///   - subpath:    URL including the base url
       ///   - httpMethod: Http methods
       ///   - encoding:   Encodes values into a url-encoded string to be set as or appended to any existing URL query string or set as the HTTP body of the request
       ///   - params:     Custom key-value pair parameters for http body
       ///   - callback:   Completion handler with specific type of result and error
  private func doMethod<T: Mappable>(_ fullPath: String, httpMethod: HTTPMethod, encoding: ParameterEncoding, params: [String: Any], callback: @escaping (_ result: T?, _ error: Error?) -> Void) {
           executeRequest(fullPath, method: httpMethod, encoding: encoding, params: params) { (data, response, error) in
       
              do {
                  //to get JSON return value
                if let data = data, let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
                    let mappedObject = Mapper<T>().map(JSON: json)
                        callback(mappedObject, nil)
                        
                       }
              } catch {

              }
             
           }
       }
    
    
    
    /// General method to execute get, post or delete method
    /// - Parameters:
    ///   - fullPath:   URL including the base url
    ///   - method:     Http methods
    ///   - encoding:   Encodes values into a url-encoded string to be set as or appended to any existing URL query string or set as the HTTP body of the request
    ///   - params:     Custom key-value pair parameters for http body
    ///   - completion: Completion handler with the json type of response
    private func executeRequest(_ fullPath: String, method: HTTPMethod, encoding: ParameterEncoding, params: [String: Any], completion: @escaping (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void) {
        guard var url = URLComponents(string: fullPath) else {
            return
        }
       
        
        let header: HTTPHeaders =
            ["Content-Type" : "application/json",
            ]
        url.queryItems = []
        for (key, value) in params {
          url.queryItems!.append(URLQueryItem(name: key, value: (value as! String)))
        }
      
        let request = try! URLRequest(url: url, method: method, headers: header)
        let session = URLSession.shared.dataTask(with: request) { (data, response, error) in
            completion(data, response, error)
           
        }
        session.resume()
    }
    
   
}
