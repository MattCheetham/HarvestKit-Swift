//
//  Person.swift
//  HarvestKit
//
//  Created by Matthew Cheetham on 19/11/2015.
//  Copyright © 2015 Matt Cheetham. All rights reserved.
//

import Foundation

/**
 A struct representation of a user in the harvest system
 */
public struct User {
    
    /**
     A unique identifier for this User
     */
    public var identifier: Int?
    
    /**
     The users first Name
     */
    public var firstName: String?
    
    /**
     The users last name
     */
    public var lastName: String?
    
    /**
     The users email address
     */
    public var email: String?
    
    /**
     A boolean to indicate whether or not the user is active in the system. If false, this user has been deactivated
     */
    public var active: Bool?
    
    /**
     A boolean to indicate whether or not the user is an admin in this system.
     - note: Only populated when created from the Who Am I call
     */
    public var admin: Bool?
    
    /**
     The name of the department that the user belongs to
     */
    public var department: String?
    
    /**
     The timezone identifier as a string that the user has their account set to. E.g. "Europe/London"
     - note: Only populated when created from the Who Am I call
     */
    public var timezoneIdentifier: String?
    
    /**
     The timezone city. The harvest API doesn't give any documentation on this so I'm going to assume it always returns the city part of the `timezoneIdentifier`
     - note: Only populated when created from the Who Am I call
     */
    public var timezoneCity: String?
    
    /**
     A boolean indicating whether or not the user is a project manager
     - note: Only populated when created from the Who Am I call
     */
    public var projectManager: Bool?
    
    /**
     A boolean indicating whether or not the user can create new projects
     - note: Only populated when created from the Who Am I call
     */
    public var createProjects: Bool?
    
    /**
     A boolean indicating whether or not the user can see hourly rates
     - note: Only populated when created from the Who Am I call
     */
    public var seeRates: Bool?
    
    /**
     A boolean indicating whether or not the user can create new invoices
     - note: Only populated when created from the Who Am I call
     */
    public var createInvoices: Bool?
    
    /**
     The number of seconds that the user is offset from UTC with their current timezone settings
     - note: Only populated when created from the Who Am I call
     */
    public var timezoneOffsetSeconds: Int?
    
    /**
     No information was found about this property in the Harvest API Documentation
     - note: Only populated when created from the Who Am I call
     */
    public var timestampTimers: Bool?
    
    /**
     The URL to the users avatar if they have one
     - note: Only populated when created from the Who Am I call
     */
    public var avatarURL: URL?
    
    internal init?(dictionary: [String: AnyObject]) {
        
        guard let userDictionary = dictionary["user"] as? [String: AnyObject] else {
            print("User was missing user key")
            return nil
        }
        
        identifier = userDictionary["id"] as? Int
        firstName = userDictionary["first_name"] as? String
        lastName = userDictionary["last_name"] as? String
        email = userDictionary["email"] as? String
        active = userDictionary["is_active"] as? Bool
        admin = userDictionary["admin"] as? Bool
        department = userDictionary["department"] as? String
        timezoneIdentifier = userDictionary["timezone_identifier"] as? String
        timezoneCity = userDictionary["timezone"] as? String
        
        if let projectManagerDictionary = userDictionary["project_manager"] as? [String: AnyObject] {
            
            projectManager = projectManagerDictionary["is_project_manager"] as? Bool
            createProjects = projectManagerDictionary["can_create_projects"] as? Bool
            seeRates = projectManagerDictionary["can_see_rates"] as? Bool
            createInvoices = projectManagerDictionary["can_create_invoices"] as? Bool
        }
        
        timezoneOffsetSeconds = userDictionary["timezone_utc_offset"] as? Int
        timestampTimers = userDictionary["timestamp_timers"] as? Bool
        
        if let avatarURLString = userDictionary["avatar_url"] as? String {
            avatarURL = URL(string: avatarURLString)
        }
        
    }
    
}
