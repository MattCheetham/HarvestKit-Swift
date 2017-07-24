//
//  DateExtensions.swift
//  HarvestKit
//
//  Created by Matthew Cheetham on 21/11/2015.
//  Copyright © 2015 Matt Cheetham. All rights reserved.
//

import Foundation

/**
Useful extensions of NSDate that allow easy access to date information. This extension is used for converting dates to formats that are used by the Harvest API
*/
public extension Date {
    
    /**
    The day number in the date's year, as a String
    */
    public var dayInYear: String {
        return String((Calendar.current as NSCalendar).ordinality(of: .day, in: .year, for: self))
    }
    
    /**
    The date's year, as a String
    */
    public var year: String {
        return String((Calendar.current as NSCalendar).component(.year, from: self))
    }
    
}
