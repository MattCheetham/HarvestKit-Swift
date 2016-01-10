//
//  SerializableExtensions.swift
//  HarvestKit
//
//  Created by Matthew Cheetham on 10/01/2016.
//  Copyright © 2016 Matt Cheetham. All rights reserved.
//

import Foundation

/**
Extends timer to make it serializable
*/
public extension Timer {
    
    /**
    A dictionary representation of the timer which can be submitted to the API to create a new timer
    */
    var serialisedObject: [String: AnyObject] {
        
        var mutableDictionary = [String: AnyObject]()
        
        if let projectId = projectIdentifier {
            mutableDictionary["project_id"] = projectId
        }
        
        if let taskId = taskIdentifier {
            mutableDictionary["task_id"] = taskId
        }
        
        if let inputHours = hours {
            mutableDictionary["hours"] = inputHours
        }
        
        if let inputNotes = notes {
            mutableDictionary["notes"] = inputNotes
        }
        
        return mutableDictionary
    }
}