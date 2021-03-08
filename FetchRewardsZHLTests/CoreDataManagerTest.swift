//
//  CoreDataManagerTest.swift
//  FetchRewardsZHL
//
//  Created by Jeremy on 3/7/21.
//

import XCTest
@testable import FetchRewardsZHL
import UIKit
import CoreData
class CoreDataManagerTest: XCTestCase {
  var sut: CoreDataManager!
  var delegate: MockAppDelegate!
  var managedContext: NSManagedObjectContext!
  override func setUp() {
    super.setUp()
    sut = CoreDataManager()
    delegate = MockAppDelegate()
    sut.appDelegate = delegate
    managedContext = delegate.persistentContainer.viewContext
  }
  
  func testIsSaved() {
    // 1
    let expectedId = 1
    sut.saveLikedEvent(id: expectedId)
    var resultID = 0
    var liked = false
    
    // 2

    let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Event")
    request.returnsObjectsAsFaults = false
    do {
       let result = try managedContext.fetch(request)
       for data in result as! [NSManagedObject] {
        resultID = data.value(forKey: "id") as! Int
        liked = data.value(forKey: "isLiked") as! Bool
        
       }
    } catch {
    }
  
    //3
    XCTAssertTrue(resultID == expectedId)
    XCTAssertTrue(liked)
  }
  
  func testDeleteEvent() {
    //1
    let savedID = 1
    sut.saveLikedEvent(id: savedID)
    var resultID = 0
    var liked = false
    
    //2
    sut.deleteLikedEvent(id: savedID)
    let entity = NSEntityDescription.entity(forEntityName: "Event", in: managedContext)
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
    fetchRequest.entity = entity
    fetchRequest.predicate = NSPredicate(format: "id== %d", savedID)
    do {
       let result = try managedContext.fetch(fetchRequest)
       for data in result as! [NSManagedObject] {
        resultID = data.value(forKey: "id") as! Int
        liked = data.value(forKey: "isLiked") as! Bool
        
       }
    } catch {
    }
    
    //3
    XCTAssertTrue(resultID == 0)
    XCTAssertTrue(!liked)
    
  }
  
  func testLoadEvent() {
    //1
    let savedID = 1
    var resultID = 0
    var liked = false
    
    //2
    sut.saveLikedEvent(id: savedID)
    let entity = NSEntityDescription.entity(forEntityName: "Event", in: managedContext)
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
    fetchRequest.entity = entity
    fetchRequest.predicate = NSPredicate(format: "id== %d", savedID)
    do {
       let result = try managedContext.fetch(fetchRequest)
       for data in result as! [NSManagedObject] {
        resultID = data.value(forKey: "id") as! Int
        liked = data.value(forKey: "isLiked") as! Bool
        
       }
    } catch {
    }
    
    //3
    XCTAssertTrue(resultID == 1)
    XCTAssertTrue(liked)
    
  }
  
  

}
