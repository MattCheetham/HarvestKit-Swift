//
//  TimersController.swift
//  HarvestKit
//
//  Created by Matthew Cheetham on 16/01/2016.
//  Copyright © 2016 Matt Cheetham. All rights reserved.
//

import Foundation

#if os(iOS)
    import ThunderRequest
#elseif os(tvOS)
    import ThunderRequestTV
#elseif os (OSX)
    import ThunderRequestMac
#endif

/**
Handles loading information about timers
*/
public final class TimersController {
    
    /**
     The request controller used to load timer information. This is shared with other controllers
     */
    public let requestController: TSCRequestController

    internal init(requestController: TSCRequestController) {
        
        self.requestController = requestController
        
    }
    
    //MARK: - Creating Timers
    
    /**
    Creates a new timer entry in the Harvest system. You may set projectIdentifier, taskIdentifier, notes and hours on the timer.
    
    - parameter timer: The new timer object to send to the API
    - parameter completionHandler: The completion handler to return the created timer object and errors to
    
    - requires: `projectIdentifier` and `taskIdentifier` on the timer object
    - note: If the timer does not have hours set then the API will start the timer running
    */
    public func create(_ timer: Timer, completionHandler: @escaping (_ resultTimer: Timer?, _ requestError: Error?) -> ()) {
        
        guard let _ = timer.projectIdentifier else {
            
            let error = NSError(domain: "co.uk.mattcheetham.harvestkit", code: 400, userInfo: [NSLocalizedDescriptionKey: "Timer does not have a project identifier"])
            completionHandler(nil, error)
            return
        }
        
        guard let _ = timer.taskIdentifier else {
            
            let error = NSError(domain: "co.uk.mattcheetham.harvestkit", code: 400, userInfo: [NSLocalizedDescriptionKey: "Timer does not have a task identifier"])
            completionHandler(nil, error)
            return
        }
        
        requestController.post("daily/add", bodyParams: timer.serialisedObject) { (response: TSCRequestResponse?, requestError: Error?) -> Void in
            
            if let error = requestError {
                completionHandler(nil, error)
                return
            }
            
            if let timerResponse = response {
                
                if let timerResponseDictionary = timerResponse.dictionary as? [String: AnyObject] {
                    
                    let createdTimer = Timer(dictionary: timerResponseDictionary)
                    completionHandler(createdTimer, nil)
                    return
                    
                }
                
            }
            
            let error = NSError(domain: "co.uk.mattcheetham.harvestkit", code: 400, userInfo: [NSLocalizedDescriptionKey: "The server did not return a valid timer object"])
            completionHandler(nil, error)
            
        }
        
    }
    
    //MARK: - Retrieving Timers
    
    /**
    Gets timers for a given user on a given day. If no user is specified, the authenticated user will be used. If no date is specified, today will be used
    
    - parameter user: The user to look up the data for. If no user is specified, the authenticated user will be used
    - parameter date: The date as an Date to return timers for. If no date is supplied today will be used instead
    - parameter completionHandler: The completion handler to return timers and errors to
    */
    public func getTimers(_ user: User? = nil, date: Date? = nil, completionHandler: @escaping (_ timers: [Timer?]?, _ requestError: Error?) -> ()) {
        
        var url = URL(string: "daily")!
        
        //Configures date if specified
        if let givenDate = date {
            
            url = url.appendingPathComponent(givenDate.dayInYear)
            url = url.appendingPathComponent(givenDate.year)
        }
        
        //Configures user if specified
        if let givenUser = user, let userId = givenUser.identifier {
            url = url.appendingPathComponent("?of_user=\(userId)")
        }
        
        let path = url.path
        
        //Makes the request for timers
        requestController.get(path) { (response: TSCRequestResponse?, requestError: Error?) -> Void in
            
            if let error = requestError {
                completionHandler(nil, error)
                return;
            }
            
            if let timerResponseDictionary = response?.dictionary as? [String: AnyObject], let timerEntriesArray = timerResponseDictionary["day_entries"] as? [[String: AnyObject]] {
                
                let timersArray = timerEntriesArray.map({
                    Timer(dictionary: $0)
                })
                
                completionHandler(timersArray, nil)
            }
        }
    }
    
    /**
     Gets a timer for a specific ID
     
     - parameter identifier: The identifier for a timer
     - parameter completionHandler: The completion handler to return the timer and errors to
     */
    public func getTimer(_ identifier: Int, completionHandler: @escaping (_ timer: Timer?, _ requestError: Error?) -> ()) {
        
        requestController.get("daily/show/(:timerIdentifier)", withURLParamDictionary: ["timerIdentifier":identifier]) { (response: TSCRequestResponse?, requestError: Error?) -> Void in
            
            if let error = requestError {
                completionHandler(nil, error)
                return
            }
            
            if let timerResponse = response {
                
                if let timerResponseDictionary = timerResponse.dictionary as? [String: AnyObject] {
                    
                    let foundTimer = Timer(dictionary: timerResponseDictionary)
                    completionHandler(foundTimer, nil)
                    return
                    
                }
                
            }
            
            let error = NSError(domain: "co.uk.mattcheetham.harvestkit", code: 400, userInfo: [NSLocalizedDescriptionKey: "The server did not return a valid timer object"])
            completionHandler(nil, error)
            
        }
        
    }
    
    //MARK: Adjusting Timers
    
    /**
    Toggles the given timer. If the timer is on, it will turn off, if it is off, it will turn on.
    
    - parameter timer: The timer to toggle
    - parameter completionHandler: The completion handler to return whether or not the toggle was successful, the updated timer and any request errors
    
    - note: if your account uses timestamp timers, timers cannot be restarted. Instead, a new timer will be created with the same project, task, and notes.
    */
    public func toggle(_ timer: Timer?, completionHandler: @escaping (_ success: Bool?, _ updatedTimer: Timer?, _ requestError: Error?) -> ()) {
        
        guard let givenTimer = timer, let timerIdentifier = givenTimer.identifier else {
            let error = NSError(domain: "co.uk.mattcheetham.harvestkit", code: 1000, userInfo: [NSLocalizedDescriptionKey: "No timer supplied or timer did not have an ID"])
            completionHandler(false, nil, error)
            return;
        }
        
        requestController.get("daily/timer/(:timerIdentifier)", withURLParamDictionary: ["timerIdentifier":timerIdentifier]) { (response: TSCRequestResponse?, requestError: Error?) -> Void in
            
            if let error = requestError {
                completionHandler(false, nil, error)
                return;
            }
            
            if let toggleResponse = response {
                
                if toggleResponse.status == 200 {
                    
                    var newTimer: Timer?
                    if let responseDictionary = response?.dictionary as? [String: AnyObject] {
                        newTimer = Timer(dictionary: responseDictionary)
                    }
                    
                    completionHandler(true, newTimer, nil)
                    return;
                }
            }
            
        }
        
    }
    
    /**
     Deletes the given timer. Will return an error of 404 if the timer has already been deleted or is not valid
     
     - parameter timer: The timer to delete
     - parameter completionHandler: The completion handler to return request errors to
     */
    public func delete(_ timer: Timer?, completionHandler: @escaping (_ requestError: Error?) -> ()) {
        
        guard let givenTimer = timer, let timerIdentifier = givenTimer.identifier else {
            let error = NSError(domain: "co.uk.mattcheetham.harvestkit", code: 1000, userInfo: [NSLocalizedDescriptionKey: "No timer supplied or timer did not have an ID"])
            completionHandler(error)
            return;
        }
        
        requestController.delete("daily/delete/(:timerIdentifier)", withURLParamDictionary: ["timerIdentifier":timerIdentifier]) { (response: TSCRequestResponse?, requestError: Error?) -> Void in
            
            if let error = requestError {
                completionHandler(error)
                return;
            }
            
            completionHandler(nil)
            
        }
        
    }
    
    /**
     Updates a timer. The timer must have an identifier to be updated. All other properties will be updated in the system.
     
     - parameter timer: The timer to update. You may modify a timer returned from another request or create a new one that has a valid identifier
     - parameter completionHandler: The completion handler to return request errors to as well as the updated timer
     */
    public func update(_ timer: Timer, completionHandler: @escaping (_ updatedTimer: Timer?, _ requestError: Error?) -> ()) {
        
        guard let timerIdentifier = timer.identifier else {
            let error = NSError(domain: "co.uk.mattcheetham.harvestkit", code: 1000, userInfo: [NSLocalizedDescriptionKey: "Supplied timer does not have an identifier"])
            completionHandler(nil, error)
            return;
        }
        
        requestController.post("daily/update/(:timerIdentifier)", withURLParamDictionary: ["timerIdentifier":timerIdentifier], bodyParams: timer.serialisedObject) { (response: TSCRequestResponse?, requestError: Error?) -> Void in
            
            if let error = requestError {
                completionHandler(nil, error)
                return
            }
            
            if let toggleResponse = response {
                
                if toggleResponse.status == 200 {
                    
                    var newTimer: Timer?
                    if let responseDictionary = response?.dictionary as? [String: AnyObject] {
                        newTimer = Timer(dictionary: responseDictionary)
                    }
                    
                    completionHandler(newTimer, nil)
                    return;
                }
            }
            
            let error = NSError(domain: "co.uk.mattcheetham.harvestkit", code: 400, userInfo: [NSLocalizedDescriptionKey: "The server did not return a valid timer object"])
            completionHandler(nil, error)
            return
        }
        
    }

    
}
