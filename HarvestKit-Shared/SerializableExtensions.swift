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

/**
Extends contact to make it serializable
*/
public extension Contact {
    
    /**
    A dictionary representation of the contact which can be submitted to the API to create a new contact or update an existing one
    */
    var serialisedObject: [String: AnyObject] {
        
        var mutableDictionary = [String: AnyObject]()
        
        var mutableContactContainer = [String: AnyObject]()
        
        if let clientIdentifier = clientIdentifier {
            mutableContactContainer["client_id"] = clientIdentifier
        }
        
        if let clientTitle = title {
            mutableContactContainer["title"] = clientTitle
        }
        
        if let clientFirstName = firstName {
            mutableContactContainer["first_name"] = clientFirstName
        }
        
        if let clientLastName = lastName {
            mutableContactContainer["last_name"] = clientLastName
        }
        
        if let clientEmail = email {
            mutableContactContainer["email"] = clientEmail
        }
        
        if let clientOfficePhone = officePhoneNumber {
            mutableContactContainer["phone_office"] = clientOfficePhone
        }
        
        if let clientMobilePhone = mobilePhoneNumber {
            mutableContactContainer["phone_mobile"] = clientMobilePhone
        }
        
        if let clientFax = faxNumber {
            mutableContactContainer["fax"] = clientFax
        }
                
        mutableDictionary["contact"] = mutableContactContainer
        
        return mutableDictionary
    }
    
}