//
//  Client.swift
//  HarvestKit
//
//  Created by Matthew Cheetham on 19/11/2015.
//  Copyright © 2015 Matt Cheetham. All rights reserved.
//

import Foundation

/**
 A struct representation of a client in the harvest system
 */
public struct Client {
    
    /**
     A unique identifier for this Client
     */
    public var identifier: Int?
    
    /**
     The clients name
     */
    public var name: String?
    
    /**
     The same as the `address` property. This property will take precedence over the `address` property despite `address` technically being what is displayed on the website for Harvest. You can use either property to set the fields
 */
    public var details: String?
    
    /**
     The currency that the client makes/recieves payments in. As a full length description.
     */
    public var currencyName: String?
    
    /**
     The currency symbol representing the currency that the client makes/recieves payments in
     */
    public var currencySymbol: String?
    
    /**
     A boolean to indicate whether or not the client is active in the system. If false, this client has been archived
     */
    public var active: Bool?
    
    public var defaultInvoiceKind: String?
    
    public var lastInvoiceKind: String?
    
    public var defaultInvoiceTimeframe: String?
    
    /**
     The date that the client was created
     */
    public var created: Date?
    
    /**
     The date that this client was last updated
     */
    public var updated: Date?
    
    public var highriseId: Int?
    
    /**
     The clients address that they can be contacted at. Same as the `details` property although if setting both to different values which isn't possible, the details property will take precedence.
     */
    public var address: String?
    
    public var cacheVersion: Int?
    
    public var statementKey: String?
    
    internal init?(dictionary: [String: AnyObject]) {
        
        guard let clientDictionary = dictionary["client"] as? [String: AnyObject] else {
            print("Dictionary was missing client key")
            return nil
        }
        
        identifier = clientDictionary["id"] as? Int
        name = clientDictionary["name"] as? String
        details = clientDictionary["details"] as? String
        currencyName = clientDictionary["currency"] as? String
        currencySymbol = clientDictionary["currency_symbol"] as? String
        active = clientDictionary["active"] as? Bool
        lastInvoiceKind = clientDictionary["last_invoice_kind"] as? String
        defaultInvoiceKind = clientDictionary["default_invoice_kind"] as? String
        cacheVersion = clientDictionary["cache_version"] as? Int
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        
        if let createdDateString = clientDictionary["created_at"] as? String {
            created = dateFormatter.date(from: createdDateString)
        }
        
        if let updatedDateString = clientDictionary["updated_at"] as? String {
            updated = dateFormatter.date(from: updatedDateString)
        }
        
        highriseId = clientDictionary["highrise_id"] as? Int
        defaultInvoiceTimeframe = clientDictionary["default_invoice_timeframe"] as? String
        statementKey = clientDictionary["statement_key"] as? String
    }
    
}
