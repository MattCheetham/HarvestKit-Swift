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
            mutableDictionary["project_id"] = projectId as AnyObject?
        }
        
        if let taskId = taskIdentifier {
            mutableDictionary["task_id"] = taskId as AnyObject?
        }
        
        if let inputHours = hours {
            mutableDictionary["hours"] = inputHours as AnyObject?
        }
        
        if let inputNotes = notes {
            mutableDictionary["notes"] = inputNotes as AnyObject?
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
            mutableContactContainer["client_id"] = clientIdentifier as AnyObject?
        }
        
        if let clientTitle = title {
            mutableContactContainer["title"] = clientTitle as AnyObject?
        }
        
        if let clientFirstName = firstName {
            mutableContactContainer["first_name"] = clientFirstName as AnyObject?
        }
        
        if let clientLastName = lastName {
            mutableContactContainer["last_name"] = clientLastName as AnyObject?
        }
        
        if let clientEmail = email {
            mutableContactContainer["email"] = clientEmail as AnyObject?
        }
        
        if let clientOfficePhone = officePhoneNumber {
            mutableContactContainer["phone_office"] = clientOfficePhone as AnyObject?
        }
        
        if let clientMobilePhone = mobilePhoneNumber {
            mutableContactContainer["phone_mobile"] = clientMobilePhone as AnyObject?
        }
        
        if let clientFax = faxNumber {
            mutableContactContainer["fax"] = clientFax as AnyObject?
        }
                
        mutableDictionary["contact"] = mutableContactContainer as AnyObject?
        
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
            mutableClientContainer["id"] = _identifier as AnyObject?
        }

        if let _name = name {
            mutableClientContainer["name"] = _name as AnyObject?
        }
        
        if let _details = details {
            mutableClientContainer["details"] = _details as AnyObject?
        }
        
        if let _currencyName = currencyName {
            mutableClientContainer["currency"] = _currencyName as AnyObject?
        }
        
        if let _currencySymbol = currencySymbol {
            mutableClientContainer["currency_symbol"] = _currencySymbol as AnyObject?
        }
        
        if let _active = active {
            mutableClientContainer["active"] = _active as AnyObject?
        }
        
        if let _defaultInvoiceKind = defaultInvoiceKind {
            mutableClientContainer["default_invoice_kind"] = _defaultInvoiceKind as AnyObject?
        }
        
        if let _lastInvoiceKind = lastInvoiceKind {
            mutableClientContainer["last_invoice_kind"] = _lastInvoiceKind as AnyObject?
        }
        
        if let _defaultInvoiceTimeFrame = defaultInvoiceTimeframe {
            mutableClientContainer["default_invoice_timeframe"] = _defaultInvoiceTimeFrame as AnyObject?
        }
        
        if let _highriseId = highriseId {
            mutableClientContainer["highrise_id"] = _highriseId as AnyObject?
        }
        
        if let _address = address {
            mutableClientContainer["address"] = _address as AnyObject?
        }
        
        if let _cacheVersion = cacheVersion {
            mutableClientContainer["cache_version"] = _cacheVersion as AnyObject?
        }
        
        if let _statementKey = statementKey {
            mutableClientContainer["statement_key"] = _statementKey as AnyObject?
        }
        
        mutableDictionary["client"] = mutableClientContainer as AnyObject?
        
        return mutableDictionary
    }
}
