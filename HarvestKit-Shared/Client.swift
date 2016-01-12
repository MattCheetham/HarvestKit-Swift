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
     Any additional details about the client
     */
    public var details: String?
    
    /**
     The currency that the client makes/recieves payments in
     */
    public var currencySymbol: String?
    
    /**
     A boolean to indicate whether or not the client is active in the system. If false, this client has been archived
     */
    public var active: Bool?
    
    internal init?(dictionary: [String: AnyObject]) {
        
        guard let clientDictionary = dictionary["client"] as? [String: AnyObject] else {
            print("Dictionary was missing client key")
            return nil
        }
        
        identifier = clientDictionary["id"] as? Int
        name = clientDictionary["name"] as? String
        details = clientDictionary["details"] as? String
        currencySymbol = clientDictionary["currency_symbol"] as? String
        active = clientDictionary["active"] as? Bool
        
    }
    
}