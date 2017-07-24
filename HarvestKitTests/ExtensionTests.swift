//
//  ExtensionTests.swift
//  HarvestKit
//
//  Created by Matthew Cheetham on 10/01/2016.
//  Copyright © 2016 Matt Cheetham. All rights reserved.
//

import XCTest
import ThunderRequest
@testable import HarvestKitiOS

class ExtensionTests: TestBase {
    
    func testGeneratingSerialisableTimer() {
        
        let timerObject = loadDictionaryForFile("timer")
        
        if let timerDictionary = timerObject {
            
            let timer = Timer(dictionary: timerDictionary)
            
            if let generatedTimer = timer {
                
                XCTAssertNotNil(generatedTimer.serialisedObject)
                
                let serialisedObject = generatedTimer.serialisedObject
                
                XCTAssertNotNil(serialisedObject["project_id"])
                XCTAssertNotNil(serialisedObject["task_id"])
                XCTAssertNotNil(serialisedObject["hours"])
                XCTAssertNotNil(serialisedObject["notes"])
                
            }
        }
        
    }
    
    func testDayInYearFromDate() {
        
        let date = Date(timeIntervalSince1970: 1451072513)
        
        XCTAssertEqual(date.dayInYear, "359")
        
    }
    
    func testYearOfDate() {
        
        let date = Date(timeIntervalSince1970: 1451072513)
        
        XCTAssertEqual(date.year, "2015")
        
    }
    
}
