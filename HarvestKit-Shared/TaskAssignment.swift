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
        
        identifier = dictionary["task_id"] as? String
    }
}
