//
//  Timer.swift
//  HarvestKit
//
//  Created by Matthew Cheetham on 19/11/2015.
//  Copyright © 2015 Matt Cheetham. All rights reserved.
//

import Foundation

/**
A struct representation of a timer entry in the harvest system
*/
public struct Timer {

    /**
     A unique identifier for this timer
     */
    public var identifier: Int?
    
    /**
    Any notes the user has attatched to the entry
    */
    public var notes: String?
    
    /**
    The name of the client that the timer belongs to
    */
    public var clientName: String?
    
    /**
    The name of the project that the timer falls under
    */
    public var projectName: String?
    
    /**
    The name of the task that the timer falls under
    */
    public var taskName: String?
    
    /**
     A boolean to indicate whether or not the timer is currently active.
     */
    public var active = false
    
    /**
    The number of hours that the Timer has been running for
    */
    public var hours: Double?
    
    /**
    The number of hours that the Timer was manually adjusted to be running to.
    If the user has the timer running for an hour but then manually edits it to be 2.5 hours this property will show 1.5 hours.
    */
    public var hoursWithoutTimer: Double?
    
    internal init(dictionary: [String: AnyObject]) {
        
        identifier = dictionary["id"] as? Int
        notes = dictionary["notes"] as? String
        clientName = dictionary["client"] as? String
        projectName = dictionary["project"] as? String
        taskName = dictionary["task"] as? String
        hours = dictionary["hours"] as? Double
        hoursWithoutTimer = dictionary["hours_without_timer"] as? Double
        
        if let _ = dictionary["timer_started_at"] as? String {
            active = true
        }
        
    }

}