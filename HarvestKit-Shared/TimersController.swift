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
    let requestController: TSCRequestController
    
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
    public func create(timer: Timer, completionHandler: (resultTimer: Timer?, requestError: NSError?) -> ()) {
        
        guard let _ = timer.projectIdentifier else {
            
            let error = NSError(domain: "co.uk.mattcheetham.harvestkit", code: 400, userInfo: [NSLocalizedDescriptionKey: "Timer does not have a project identifier"])
            completionHandler(resultTimer: nil, requestError: error)
            return
        }
        
        guard let _ = timer.taskIdentifier else {
            
            let error = NSError(domain: "co.uk.mattcheetham.harvestkit", code: 400, userInfo: [NSLocalizedDescriptionKey: "Timer does not have a task identifier"])
            completionHandler(resultTimer: nil, requestError: error)
            return
        }
        
        requestController.post("daily/add", bodyParams: timer.serialisedObject) { (response: TSCRequestResponse?, requestError: NSError?) -> Void in
            
            if let error = requestError {
                completionHandler(resultTimer: nil, requestError: error)
                return
            }
            
            if let timerResponse = response {
                
                if let timerResponseDictionary = timerResponse.dictionary as? [String: AnyObject] {
                    
                    let createdTimer = Timer(dictionary: timerResponseDictionary)
                    completionHandler(resultTimer: createdTimer, requestError: nil)
                    return
                    
                }
                
            }
            
            let error = NSError(domain: "co.uk.mattcheetham.harvestkit", code: 400, userInfo: [NSLocalizedDescriptionKey: "The server did not return a valid timer object"])
            completionHandler(resultTimer: nil, requestError: error)
            
        }
        
    }
    
    //MARK: - Retrieving Timers
    
    /**
    Gets timers for a given user on a given day. If no user is specified, the authenticated user will be used. If no date is specified, today will be used
    
    - parameter user: The user to look up the data for. If no user is specified, the authenticated user will be used
    - parameter date: The date as an NSDate to return timers for. If no date is supplied today will be used instead
    - parameter completionHandler: The completion handler to return timers and errors to
    */
    public func getTimers(user: User?, date: NSDate?, completionHandler: (timers: [Timer?]?, requestError: NSError?) -> ()) {
        
        var url = NSURL(string: "daily")!
        
        //Configures date if specified
        if let givenDate = date {
            
            url = url.URLByAppendingPathComponent(givenDate.dayInYear)
            url = url.URLByAppendingPathComponent(givenDate.year)
        }
        
        //Configures user if specified
        if let givenUser = user, let userId = givenUser.identifier {
            url = url.URLByAppendingPathComponent("?of_user=\(userId)")
        }
        
        //Check we have a valid URL
        guard let path = url.path else {
            
            let error = NSError(domain: "co.uk.mattcheetham.harvestkit", code: 400, userInfo: [NSLocalizedDescriptionKey: "Data supplied did not result in a valid request for the Harvest API. Please check your date object is valid (if supplied) and that your given user has a valid identifier (if supplied)"])
            completionHandler(timers: nil, requestError: error)
            return
        }
        
        //Makes the request for timers
        requestController.get(path) { (response: TSCRequestResponse?, requestError: NSError?) -> Void in
            
            if let error = requestError {
                completionHandler(timers: nil, requestError: error)
                return;
            }
            
            if let timerResponseDictionary = response?.dictionary as? [String: AnyObject], let timerEntriesArray = timerResponseDictionary["day_entries"] as? [[String: AnyObject]] {
                
                let timersArray = timerEntriesArray.map({
                    Timer(dictionary: $0)
                })
                
                completionHandler(timers: timersArray, requestError: nil)
                
            }
            
        }
        
    }
    
    /**
     Gets timers for a given user for the current day. If no user is specified, the authenticated user will be used.
     
     - parameter user: The user to look up the data for. If no user is specified, the authenticated user will be used
     - parameter completionHandler: The completion handler to return timers and errors to
     */
    public func getTimers(user: User?, completionHandler: (timers: [Timer?]?, requestError: NSError?) -> ()) {
        getTimers(user, date: nil, completionHandler: completionHandler)
    }
    
    /**
     Gets timers for the authenticated user for the given day. If no day is specified, today will be used.
     
     - parameter date: THe date as an NSDate to return timers for. If no date is supplied today will be used instead
     - parameter completionHandler: The completion handler to return timers and errors to
     */
    public func getTimers(date: NSDate?, completionHandler: (timers: [Timer?]?, requestError: NSError?) -> ()) {
        getTimers(nil, date: date, completionHandler: completionHandler)
    }
    
    /**
     Gets timers for the authenticated user for the current day
     
     - parameter completionHandler: The completion handler to return timers and errors to
     */
    public func getTimers(completionHandler: (timers: [Timer?]?, requestError: NSError?) -> ()) {
        getTimers(nil, date: nil, completionHandler: completionHandler)
    }
    
    /**
     Gets a timer for a specific ID
     
     - parameter identifier: The identifier for a timer
     - parameter completionHandler: The completion handler to return the timer and errors to
     */
    public func getTimer(identifier: Int, completionHandler: (timer: Timer?, requestError: NSError?) -> ()) {
        
        requestController.get("daily/show/(:timerIdentifier)", withURLParamDictionary: ["timerIdentifier":identifier]) { (response: TSCRequestResponse?, requestError: NSError?) -> Void in
            
            if let error = requestError {
                completionHandler(timer: nil, requestError: error)
                return
            }
            
            if let timerResponse = response {
                
                if let timerResponseDictionary = timerResponse.dictionary as? [String: AnyObject] {
                    
                    let foundTimer = Timer(dictionary: timerResponseDictionary)
                    completionHandler(timer: foundTimer, requestError: nil)
                    return
                    
                }
                
            }
            
            let error = NSError(domain: "co.uk.mattcheetham.harvestkit", code: 400, userInfo: [NSLocalizedDescriptionKey: "The server did not return a valid timer object"])
            completionHandler(timer: nil, requestError: error)
            
        }
        
    }
    
    //MARK: Adjusting Timers
    
    /**
    Toggles the given timer. If the timer is on, it will turn off, if it is off, it will turn on.
    
    - parameter timer: The timer to toggle
    - parameter completionHandler: The completion handler to return whether or not the toggle was successful, the updated timer and any request errors
    
    - note: if your account uses timestamp timers, timers cannot be restarted. Instead, a new timer will be created with the same project, task, and notes.
    */
    public func toggle(timer: Timer?, completionHandler: (success: Bool?, updatedTimer: Timer?, requestError: NSError?) -> ()) {
        
        guard let givenTimer = timer, timerIdentifier = givenTimer.identifier else {
            let error = NSError(domain: "co.uk.mattcheetham.harvestkit", code: 1000, userInfo: [NSLocalizedDescriptionKey: "No timer supplied or timer did not have an ID"])
            completionHandler(success: false, updatedTimer: nil, requestError: error)
            return;
        }
        
        requestController.get("daily/timer/(:timerIdentifier)", withURLParamDictionary: ["timerIdentifier":timerIdentifier]) { (response: TSCRequestResponse?, requestError: NSError?) -> Void in
            
            if let error = requestError {
                completionHandler(success: false, updatedTimer: nil, requestError: error)
                return;
            }
            
            if let toggleResponse = response {
                
                if toggleResponse.status == 200 {
                    
                    var newTimer: Timer?
                    if let responseDictionary = response?.dictionary as? [String: AnyObject] {
                        newTimer = Timer(dictionary: responseDictionary)
                    }
                    
                    completionHandler(success: true, updatedTimer: newTimer, requestError: nil)
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
    public func delete(timer: Timer?, completionHandler: (requestError: NSError?) -> ()) {
        
        guard let givenTimer = timer, timerIdentifier = givenTimer.identifier else {
            let error = NSError(domain: "co.uk.mattcheetham.harvestkit", code: 1000, userInfo: [NSLocalizedDescriptionKey: "No timer supplied or timer did not have an ID"])
            completionHandler(requestError: error)
            return;
        }
        
        requestController.delete("daily/delete/(:timerIdentifier)", withURLParamDictionary: ["timerIdentifier":timerIdentifier]) { (response: TSCRequestResponse?, requestError: NSError?) -> Void in
            
            if let error = requestError {
                completionHandler(requestError: error)
                return;
            }
            
            completionHandler(requestError: nil)
            
        }
        
    }
    
    /**
     Updates a timer. The timer must have an identifier to be updated. All other properties will be updated in the system.
     
     - parameter timer: The timer to update. You may modify a timer returned from another request or create a new one that has a valid identifier
     - parameter completionHandler: The completion handler to return request errors to as well as the updated timer
     */
    public func update(timer: Timer, completionHandler: (updatedTimer: Timer?, requestError: NSError?) -> ()) {
        
        guard let timerIdentifier = timer.identifier else {
            let error = NSError(domain: "co.uk.mattcheetham.harvestkit", code: 1000, userInfo: [NSLocalizedDescriptionKey: "Supplied timer does not have an identifier"])
            completionHandler(updatedTimer: nil, requestError: error)
            return;
        }
        
        requestController.post("daily/update/(:timerIdentifier)", withURLParamDictionary: ["timerIdentifier":timerIdentifier], bodyParams: timer.serialisedObject) { (response: TSCRequestResponse?, requestError: NSError?) -> Void in
            
            if let error = requestError {
                completionHandler(updatedTimer: nil, requestError: error)
                return
            }
            
            if let toggleResponse = response {
                
                if toggleResponse.status == 200 {
                    
                    var newTimer: Timer?
                    if let responseDictionary = response?.dictionary as? [String: AnyObject] {
                        newTimer = Timer(dictionary: responseDictionary)
                    }
                    
                    completionHandler(updatedTimer: newTimer, requestError: nil)
                    return;
                }
            }
            
            let error = NSError(domain: "co.uk.mattcheetham.harvestkit", code: 400, userInfo: [NSLocalizedDescriptionKey: "The server did not return a valid timer object"])
            completionHandler(updatedTimer: nil, requestError: error)
            return
        }
        
    }

    
}