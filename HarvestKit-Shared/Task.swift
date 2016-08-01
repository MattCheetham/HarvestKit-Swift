//
//  Task.swift
//  HarvestKit
//
//  Created by Matthew Cheetham on 01/08/2016.
//  Copyright © 2016 Matt Cheetham. All rights reserved.
//

import Foundation

public struct Task {
    
    /**
     A unique identifier for this Task
     */
    public var identifier: String?
    
    /**
     The name of the task to display to the user
     */
    public var name: String?
    
    public var billableByDefault: Bool?
    
    /**
     When this task was added to the system
     */
    public var created: NSDate?
    
    /**
     When this task was updated in the system
     */
    public var updated: NSDate?
    
    /**
     If this task is the default task when users create a timer entry
     */
    public var isDefault: Bool?
    
    public var defaultHourlyRate: String?
    
    public var deactivated: Bool?
    
    internal init?(dictionary: [String: AnyObject]) {
        
        guard let taskDictionary = dictionary["task"] as? [String: AnyObject] else {
            print("Dictionary was missing task key")
            return nil
        }
        
        identifier = taskDictionary["id"] as? String
        name = taskDictionary["name"] as? String
        billableByDefault = taskDictionary["billale_by_default"] as? Bool
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        
        if let createdDateString = taskDictionary["created_at"] as? String {
            created = dateFormatter.dateFromString(createdDateString)
        }
        
        if let updatedDateString = taskDictionary["updated_at"] as? String {
            updated = dateFormatter.dateFromString(updatedDateString)
        }
        
        isDefault = taskDictionary["is_default"] as? Bool
        defaultHourlyRate = taskDictionary["default_hourly_rate"] as? String
        deactivated = taskDictionary["deactivated"] as? Bool
        
    }
}