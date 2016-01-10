//
//  Project.swift
//  HarvestKit
//
//  Created by Matthew Cheetham on 19/11/2015.
//  Copyright © 2015 Matt Cheetham. All rights reserved.
//

import Foundation

/**
A struct representation of a project in the harvest system.
*/
public struct Project {
    
    /**
     A unique identifier for this Project
     */
    public var identifier: Int?
    
    /**
    A unique identifier that denotes which client this project belongs to
    */
    public var clientIdentifier: Int?
    
    /**
    A bool to indicate whether or not the project is active. If false, the project is archived
    */
    public var active: Bool?
    
    /**
    The name of the project
    */
    public var name: String?
    
    /**
    The number of hours budgeted for this project
    */
    public var budgetHours: Int?
    
    /**
    Any notes assosciated with the project
    */
    public var notes: String?
    
    internal init?(dictionary: [String: AnyObject]) {
        
        guard let projectDictionary = dictionary["project"] as? [String: AnyObject] else {
            print("Dictionary was missing project key")
            return nil
        }
        
        identifier = projectDictionary["id"] as? Int
        clientIdentifier = projectDictionary["client_id"] as? Int
        active = projectDictionary["active"] as? Bool
        name = projectDictionary["name"] as? String
        budgetHours = projectDictionary["budget"] as? Int
        notes = projectDictionary["notes"] as? String        
        
    }
    
}