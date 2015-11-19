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
#else
    
#endif

/**
The Harvest controller is responsible for all interactions with the Harvest API. It must be initialised with a TSCRequestCredential containing the API username and password
*/
public class HarvestController {
    
    let requestController = TSCRequestController(baseAddress: "https://3sidedcube.harvestapp.com")
    
    /**
    Initialises a new harvest controller with the given credential. You must supply a credential to correctly initialise.
    - parameter credential: A TSCRequestCredential initialised with an email address and password
    */
    public init(credential: TSCRequestCredential!) {
        
        requestController.sharedRequestCredential = credential
        requestController.sharedRequestHeaders["Accept"] = "application/json"
        
    }
    
    /**
    Gets a list of all registered users for the given account
    - parameter completionHandler: The completion handler to return users and errors to
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
    
    /**
    Gets an array of timers for a user for the current day
    - parameter user: The user to look up the data for
    - parameter completionHandler: The completion handler to return timers and errors to
    */
    public func getTimers(user: User?, completionHandler: (timers: [Timer]?, requestError: NSError?) -> ()) {
        
        guard let givenUser = user, let userId = givenUser.identifier else {
            let error = NSError(domain: "co.uk.mattcheetham.harvestkit", code: 1000, userInfo: [NSLocalizedDescriptionKey: "No user supplied or user did not have an ID"])
            completionHandler(timers: nil, requestError: error)
            return
        }
        
        requestController.get("daily?of_user=#(:userIdentifier)", withURLParamDictionary: ["userIdentifier":userId]) { (response: TSCRequestResponse?, requestError: NSError?) -> Void in
            
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

}
