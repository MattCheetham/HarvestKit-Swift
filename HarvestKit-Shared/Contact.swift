//
//  Contact.swift
//  HarvestKit
//
//  Created by Matthew Cheetham on 16/01/2016.
//  Copyright © 2016 Matt Cheetham. All rights reserved.
//

import Foundation

/**
 A struct representation of a project in the harvest system.
 */
public struct Contact {

    /**
    A unique identifier for the contact in the Harvest API
    */
    public var identifier: Int?
    
    /**
    A the unique identifier of the client that this contact is assosciated with
    */
    public var clientIdentifier: Int?
    
    /**
    The prefix for the name of the contact. Typically Mr, Mrs, Mx etc.
    */
    public var title: String?
    
    /**
    The first name of the contact
    */
    public var firstName: String?
    
    /**
    The last name of the contact
    */
    public var lastName: String?
    
    /**
    The email address that can be used to reach this contact
    */
    public var email: String?
    
    /**
    The phone number that can be used to reach this contact at the office. Stored as a string and may contain country codes, dashes, brackets etc.
    */
    public var officePhoneNumber: String?
    
    /**
     The phone number that can be used to reach this contact on a mobile. Stored as a string and may contain country codes, dashes, brackets etc.
     */
    public var mobilePhoneNumber: String?
    
    /**
    The number that can be used to communicate with this contact by fax. Stored as a string and may contain country codes, dashes, brackets etc.
    */
    public var faxNumber: String?
    
    /**
    The date that the contact was created
    */
    public var created: Date?
    
    /**
    The date that the contact was last modified
    */
    public var updated: Date?
    
    /**
     Standard initialiser
     */
    public init() {}
    
    internal init?(dictionary: [String: AnyObject]) {

        guard let contactDictionary = dictionary["contact"] as? [String: AnyObject] else {
            print("Dictionary was missing contact key")
            return nil
        }
        
        identifier = contactDictionary["id"] as? Int
        clientIdentifier = contactDictionary["client_id"] as? Int
        title = contactDictionary["title"] as? String
        firstName = contactDictionary["first_name"] as? String
        lastName = contactDictionary["last_name"] as? String
        email = contactDictionary["email"] as? String
        officePhoneNumber = contactDictionary["phone_office"] as? String
        mobilePhoneNumber = contactDictionary["phone_mobile"] as? String
        faxNumber = contactDictionary["fax"] as? String
        
        if let createdDateString = contactDictionary["created_at"] as? String {
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
            created = dateFormatter.date(from: createdDateString)
            
        }
        
        if let updatedDateString = contactDictionary["updated_at"] as? String {
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
            updated = dateFormatter.date(from: updatedDateString)
            
        }
        
    }
}
