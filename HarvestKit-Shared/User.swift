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
    The name of the department that the user belongs to
    */
    public var department: String?
    
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
        department = userDictionary["department"] as? String


    }
    
}