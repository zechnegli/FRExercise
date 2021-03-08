
//  CoreDataManager.swift
//  FetchRewardsZHL
//
//  Created by Jeremy on 3/7/21.
//

import Foundation
import UIKit
import CoreData
public class CoreDataManager {
   static var shared: CoreDataManager = CoreDataManager()
   var appDelegate = UIApplication.shared.delegate as? AppDelegate
  
   /// Save liked event based on its id into desk
   /// - Parameter id: Event ID
   public func saveLikedEvent(id: Int) {
    guard appDelegate != nil else {
      return
    }

    let managedContext =
      appDelegate!.persistentContainer.viewContext
    let entity =
      NSEntityDescription.entity(forEntityName: "Event",
                                 in: managedContext)!
    
    let event = NSManagedObject(entity: entity,
                                 insertInto: managedContext)
    event.setValue(id, forKeyPath: "id")
    event.setValue(true, forKeyPath: "isLiked")
    do {
      try managedContext.save()
    } catch let error as NSError {
      print("Could not save. \(error), \(error.userInfo)")
    }
  }
  
  /// load liked events from disk
  /// - Returns: [event id :  liked]
  public func loadLikedEvent() -> [Int: Bool]{
    var likedEvents = [Int: Bool]()
    guard appDelegate != nil else {
      return likedEvents
    }
    
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Event")
    let managedContext =
      appDelegate!.persistentContainer.viewContext
    request.returnsObjectsAsFaults = false
    do {
       let result = try managedContext.fetch(request)
       for data in result as! [NSManagedObject] {
        let id = data.value(forKey: "id") as! Int
        let isLiked = data.value(forKey: "isLiked") as! Bool
        likedEvents[id] = isLiked
       }
      print("finsh load")
    } catch {
       print("Fetching data Failed")
    }
    return likedEvents
  }
  
  /// delete Event from disk based on its id
  /// - Parameter id: event id
  public func deleteLikedEvent(id: Int) {
    guard appDelegate != nil else {
      return
    }
    let managedContext =
      appDelegate!.persistentContainer.viewContext
    let entity = NSEntityDescription.entity(forEntityName: "Event", in: managedContext)
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
    fetchRequest.entity = entity
    fetchRequest.predicate = NSPredicate(format: "id== %d", id)
   
    
    do {
        let objects = try managedContext.fetch(fetchRequest)
        for object in objects {
          managedContext.delete(object as! NSManagedObject)
        }
        try managedContext.save()
    } catch let error as NSError {
      print("Could not delete. \(error), \(error.userInfo)")
    }
  }
}
