//
//  ModelTests.swift
//  HarvestKit
//
//  Created by Matthew Cheetham on 10/01/2016.
//  Copyright © 2016 Matt Cheetham. All rights reserved.
//

import XCTest
import ThunderRequest
@testable import HarvestKitiOS

class ModelTests: TestBase {
    
    func testCreatingTimerViaStandardInit() {
        
        let timer = Timer()
        XCTAssertNotNil(timer)
    }
    
    func testCreatingTimerFromJSON() {
        
        let timerObject = loadDictionaryForFile("timer")
        
        XCTAssertNotNil(timerObject)
        
        if let timerDictionary = timerObject {
            
            let timer = Timer(dictionary: timerDictionary)
            
            XCTAssertNotNil(timer)
            
            if let generatedTimer = timer {
                
                XCTAssertNotNil(generatedTimer.identifier)
                XCTAssertNotNil(generatedTimer.projectName)
                XCTAssertNotNil(generatedTimer.projectIdentifier)
                XCTAssertNotNil(generatedTimer.taskName)
                XCTAssertNotNil(generatedTimer.taskIdentifier)
                XCTAssertNotNil(generatedTimer.hours)
                XCTAssertNotNil(generatedTimer.hoursWithoutTimer)
                XCTAssertNotNil(generatedTimer.clientName)
            }

        }
        
    }
    
    func testCreatingClientFromJSON() {
        
        let clientObject = loadDictionaryForFile("client")
        
        XCTAssertNotNil(clientObject)
        
        if let clientDictionary = clientObject {
            
            let client = Client(dictionary: clientDictionary)
            
            XCTAssertNotNil(client)
            
            if let generatedClient = client {
                
                XCTAssertNotNil(generatedClient.identifier)
                XCTAssertNotNil(generatedClient.name)
                XCTAssertNotNil(generatedClient.active)
                XCTAssertNotNil(generatedClient.currencySymbol)
                XCTAssertNotNil(generatedClient.details)
            }

        }
        
    }
    
    func testCreatingClientFromJSONWithMissingClientKey() {
        
        let clientObject = loadDictionaryForFile("errorObject")
        
        XCTAssertNotNil(clientObject)
        
        if let clientDictionary = clientObject {
            
            let client = Client(dictionary: clientDictionary)
            
            XCTAssertNil(client)
            
        }
        
    }
    
    func testCreatingUserFromJSON() {
        
        let userObject = loadDictionaryForFile("user")
        
        XCTAssertNotNil(userObject)
        
        if let userDictionary = userObject {
            
            let user = User(dictionary: userDictionary)
            
            XCTAssertNotNil(user)
            
            if let generatedUser = user {
                
                XCTAssertNotNil(generatedUser.identifier)
                XCTAssertNotNil(generatedUser.firstName)
                XCTAssertNotNil(generatedUser.lastName)
                XCTAssertNotNil(generatedUser.email)
                XCTAssertNotNil(generatedUser.department)
                XCTAssertNotNil(generatedUser.active)
            }

        }
        
    }
    
    func testCreatingUserFromJSONWithMissingUserKey() {
        
        let userObject = loadDictionaryForFile("errorObject")
        
        XCTAssertNotNil(userObject)
        
        if let userDictionary = userObject {
            
            let user = User(dictionary: userDictionary)
            
            XCTAssertNil(user)
        }
        
    }
    
    func testCreatingProjectFromJSON() {
        
        let projectObject = loadDictionaryForFile("project")
        
        XCTAssertNotNil(projectObject)
        
        if let projectDictionary = projectObject {
            
            let project = Project(dictionary: projectDictionary)
            
            XCTAssertNotNil(project)
            
            if let generatedProject = project {
                
                XCTAssertNotNil(generatedProject.identifier)
                XCTAssertNotNil(generatedProject.clientIdentifier)
                XCTAssertNotNil(generatedProject.name)
                XCTAssertNotNil(generatedProject.notes)
                XCTAssertNotNil(generatedProject.budgetHours)
                XCTAssertNotNil(generatedProject.active)
                
            }

        }
        
    }
    
    func testCreatingProjectFromJSONWithMissingUserKey() {
        
        let projectObject = loadDictionaryForFile("errorObject")
        
        XCTAssertNotNil(projectObject)
        
        if let projectDictionary = projectObject {
            
            let project = Project(dictionary: projectDictionary)
            
            XCTAssertNil(project)
        }
        
    }
    
    func testCreatingContactFromJSON() {
        
        let contactObject = loadDictionaryForFile("contact")
        
        XCTAssertNotNil(contactObject)
        
        if let contactDictionary = contactObject {
            
            let contact = Contact(dictionary: contactDictionary)
            
            XCTAssertNotNil(contact)
            
            if let generatedContact = contact {
                
                XCTAssertNotNil(generatedContact.identifier)
                XCTAssertNotNil(generatedContact.clientIdentifier)
                XCTAssertNotNil(generatedContact.title)
                XCTAssertNotNil(generatedContact.firstName)
                XCTAssertNotNil(generatedContact.lastName)
                XCTAssertNotNil(generatedContact.email)
                XCTAssertNotNil(generatedContact.officePhoneNumber)
                XCTAssertNotNil(generatedContact.mobilePhoneNumber)
                XCTAssertNotNil(generatedContact.faxNumber)
                XCTAssertNotNil(generatedContact.created)
                XCTAssertNotNil(generatedContact.updated)
                
            }
            
        }
        
    }
    
    func testCreatingContactFromJSONWithMissingUserKey() {
        
        let contactObject = loadDictionaryForFile("errorObject")
        
        XCTAssertNotNil(contactObject)
        
        if let contactDictionary = contactObject {
            
            let contact = Contact(dictionary: contactDictionary)
            
            XCTAssertNil(contact)
        }
        
    }

}
