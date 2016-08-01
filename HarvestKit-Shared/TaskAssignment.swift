//
//  TaskAssignment.swift
//  HarvestKit
//
//  Created by Matthew Cheetham on 01/08/2016.
//  Copyright © 2016 Matt Cheetham. All rights reserved.
//

import Foundation

public struct TaskAssignment {
    
    /**
     A unique identifier for this Task Assignment
     */
    public var identifier: String?
    
    internal init?(dictionary: [String: AnyObject]) {
        
        guard let taskDictionary = dictionary["task_assignment"] as? [String: AnyObject] else {
            print("Dictionary was missing taskAssignment key")
            return nil
        }
        
        if let _taskId = taskDictionary["task_id"] as? Int {
            identifier = String(_taskId)
        }
//        print("dict: \(taskDictionary)")
//        identifier = taskDictionary["task_id"] as? String
    }
}
