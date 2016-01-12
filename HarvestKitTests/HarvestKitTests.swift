//
//  HarvestKitTests.swift
//  HarvestKitTests
//
//  Created by Matthew Cheetham on 10/01/2016.
//  Copyright © 2016 Matt Cheetham. All rights reserved.
//

import XCTest
import ThunderRequest
@testable import HarvestKitiOS

class HarvestKitTests: TestBase {
    
    func testCreatingHarvestController() {
        
        let controller = HarvestController(accountName: "testAccount", username: "testUsername", password: "testPassword")
        
        XCTAssertNotNil(controller)
        
    }
}
