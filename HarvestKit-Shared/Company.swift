//
//  Company.swift
//  HarvestKit
//
//  Created by Matthew Cheetham on 16/01/2016.
//  Copyright © 2016 Matt Cheetham. All rights reserved.
//

import Foundation

/**
A struct representation of a company. Typiclaly returned from the API when querying about the current authenticated user
*/
public struct Company {
    
    /**
    Determines whether or not this company account is active
    */
    public var active: Bool?
    
    /**
    The plan this buisiness is on. Determines how much their monthly payments are
    */
    public var planType: String?
    
    /**
    Not documented in Harvest Documentation. Presumably the format that timers from this account should be displayed in.
    */
    public var timeFormat: String?
    
    /**
    The URL that users must go to to access this harvest account
    */
    public var baseURL: URL?
    
    /**
    The day that this company considers to be the beginning of the working week
    */
    public var weekStartDay: String?
    
    /**
    An dictionary of objects determining what modules this company has enabled. This can determine which controllers you can use as some methods will return 404 where that feature is not enabled in the modules. Admins can configure modules.
    */
    public var modules: [String: Bool]?
    
    /**
    The seperator that should be used for numbers over a thousand if any. Helps to localise figures where appropriate
    */
    public var thousandsSeperator: String?
    
    /**
    The color scheme that the company has applied to their account in the website. You may use this to theme your application if you wish.
    */
    public var colorScheme: String?
    
    /**
    The symbol that should be use to denote a decimal. Varies per company locale.
    */
    public var decimalSymbol: String?
    
    /**
    The name of the company
    */
    public var companyName: String?
    
    /**
    The time format used by the company. 12h or 24h for example.
    */
    public var clockFormat: String?
    
    internal init(dictionary: [String: AnyObject]) {
        
        active = dictionary["active"] as? Bool
        planType = dictionary["plan_type"] as? String
        timeFormat = dictionary["time_format"] as? String
        
        if let baseURLString = dictionary["base_uri"] as? String {
            baseURL = URL(string: baseURLString)
        }
        
        weekStartDay = dictionary["week_start_day"] as? String
        modules = dictionary["modules"] as? [String: Bool]
        thousandsSeperator = dictionary["thousands_separator"] as? String
        colorScheme = dictionary["color_scheme"] as? String
        decimalSymbol = dictionary["decimal_symbol"] as? String
        companyName = dictionary["name"] as? String
        clockFormat = dictionary["clock"] as? String
        
    }
    
}
