//
//  HarvestController.swift
//  HarvestKit
//
//  Created by Matthew Cheetham on 19/11/2015.
//  Copyright © 2015 Matt Cheetham. All rights reserved.
//

#if os(iOS)
    import ThunderRequest
#elseif os(tvOS)
    import ThunderRequestTV
#elseif os (OSX)
    import ThunderRequestMac
#endif
import Foundation

/**
The Harvest controller is responsible for all interactions with the Harvest API. It must be initialised with a company name, account username and account password.
 
Currently the controller uses basic Auth to access the API but should support the OAuth flow in the future.
 */
public class HarvestController {
    
    let requestController: TSCRequestController
    
    /**
    Initialises a new harvest controller with the given credentials. You must supply credentials to log in and access the harvest API.
     
    - parameters:
        - accountName: The name of the account as used when logging into the website as 'https://xxxx.harvestapp.com' where xxxx is your account name
        - username: The username of the account to log in with. This is usually the users email address
        - password: The password for the supplied username
    */
    public init(accountName: String!, username: String!, password: String!) {
        
        requestController = TSCRequestController(baseAddress: "https://\(accountName).harvestapp.com")
        
        let userPasswordString = "\(username):\(password)"
        let userPasswordData = userPasswordString.dataUsingEncoding(NSUTF8StringEncoding)
        let base64EncodedCredential = userPasswordData?.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue: 0))
        if let base64Cred = base64EncodedCredential {
            let authString = "Basic \(base64Cred)"
            requestController.sharedRequestHeaders["Authorization"] = authString

        }
        
        requestController.sharedRequestHeaders["Accept"] = "application/json"
        
    }
    
    //MARK: - Users
    
    /**
    Gets all registered users for the given account
    
    - parameters:
        - completionHandler: The completion handler to return users and errors to
    */
    public func getUsers(completionHandler: (users: [User]?, requestError: NSError?) -> ()) {
        
        requestController.get("people") { (response: TSCRequestResponse?, requestError: NSError?) -> Void in
        
            if let error = requestError {
                completionHandler(users: nil, requestError: error)
                return;
            }
            
            if let usersArray = response?.array as? [[String: AnyObject]] {
                
                let users = usersArray.map({
                    
                    User(dictionary: $0)
                    
                })
                
                completionHandler(users: users, requestError: nil)
                
            }
            
        }
        
    }
    
    //MARK: - Retrieving Timers
    
    /**
    Gets timers for a given user on a given day. If no user is specified, the authenticated user will be used. If no date is specified, today will be used
     
    - parameter user: The user to look up the data for. If no user is specified, the authenticated user will be used
    - parameter date: The date as an NSDate to return timers for. If no date is supplied today will be used instead
    - parameter completionHandler: The completion handler to return timers and errors to
    */
    public func getTimers(user: User?, date: NSDate?, completionHandler: (timers: [Timer]?, requestError: NSError?) -> ()) {
     
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
    public func getTimers(user: User?, completionHandler: (timers: [Timer]?, requestError: NSError?) -> ()) {
        getTimers(user, date: nil, completionHandler: completionHandler)
    }
    
    /**
     Gets timers for the authenticated user for the given day. If no day is specified, today will be used.
     
     - parameter date: THe date as an NSDate to return timers for. If no date is supplied today will be used instead
     - parameter completionHandler: The completion handler to return timers and errors to
     */
    public func getTimers(date: NSDate?, completionHandler: (timers: [Timer]?, requestError: NSError?) -> ()) {
        getTimers(nil, date: date, completionHandler: completionHandler)
    }
    
    /**
     Gets timers for the authenticated user for the current day
     
     - parameter completionHandler: The completion handler to return timers and errors to
     */
    public func getTimers(completionHandler: (timers: [Timer]?, requestError: NSError?) -> ()) {
        getTimers(nil, date: nil, completionHandler: completionHandler)
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
     
    //MARK: - Projects
    
    /**
    Gets projects for the account
     
    - parameters:
        - completionHandler: The completion handler to return projects and errors to
    */
    public func getProjects(completionHandler: (projects: [Project]?, requestError: NSError?) -> ()) {
        
        requestController.get("projects") { (response: TSCRequestResponse?, requestError: NSError?) -> Void in
            
            if let error = requestError {
                completionHandler(projects: nil, requestError: error)
                return;
            }
            
            if let projectsArray = response?.array as? [[String: AnyObject]] {
             
                let projects = projectsArray.map({
                    Project(dictionary: $0)
                })
                
                completionHandler(projects: projects, requestError: nil)
            }
            
        }
        
    }
    
    
    //MARK: - Clients
    
    /**
    Gets clients for the account
    
    - parameters:
        - completionHandler: The completion handler to return clients and errors to
    */
    public func getClients(completionHandler: (clients: [Client]?, requestError: NSError?) -> ()) {
        
        requestController.get("clients") { (response: TSCRequestResponse?, requestError: NSError?) -> Void in
            
            if let error = requestError {
                completionHandler(clients: nil, requestError: error)
                return;
            }
            
            if let clientsArray = response?.array as? [[String: AnyObject]] {
                
                let clients = clientsArray.map({
                    Client(dictionary: $0)
                })
                
                completionHandler(clients: clients, requestError: nil)
            }
            
        }
        
    }
}
