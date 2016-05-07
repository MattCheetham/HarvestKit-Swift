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

/**
 Extends client to make it serializable
 */
public extension Client {
    
    /**
     A dictionary representation of the client which can be submitted to the API to create a new client or update an existing one
     */
    var serialisedObject: [String: AnyObject] {
        
        var mutableDictionary = [String: AnyObject]()
        
        var mutableClientContainer = [String: AnyObject]()
        
        if let _identifier = identifier {
            mutableClientContainer["id"] = _identifier
        }

        if let _name = name {
            mutableClientContainer["name"] = _name
        }
        
        if let _details = details {
            mutableClientContainer["details"] = _details
        }
        
        if let _currencyName = currencyName {
            mutableClientContainer["currency"] = _currencyName
        }
        
        if let _currencySymbol = currencySymbol {
            mutableClientContainer["currency_symbol"] = _currencySymbol
        }
        
        if let _active = active {
            mutableClientContainer["active"] = _active
        }
        
        if let _defaultInvoiceKind = defaultInvoiceKind {
            mutableClientContainer["default_invoice_kind"] = _defaultInvoiceKind
        }
        
        if let _lastInvoiceKind = lastInvoiceKind {
            mutableClientContainer["last_invoice_kind"] = _lastInvoiceKind
        }
        
        if let _defaultInvoiceTimeFrame = defaultInvoiceTimeframe {
            mutableClientContainer["default_invoice_timeframe"] = _defaultInvoiceTimeFrame
        }
        
        if let _highriseId = highriseId {
            mutableClientContainer["highrise_id"] = _highriseId
        }
        
        if let _address = address {
            mutableClientContainer["address"] = _address
        }
        
        if let _cacheVersion = cacheVersion {
            mutableClientContainer["cache_version"] = _cacheVersion
        }
        
        if let _statementKey = statementKey {
            mutableClientContainer["statement_key"] = _statementKey
        }
        
        mutableDictionary["client"] = mutableClientContainer
        
        return mutableDictionary
    }
}