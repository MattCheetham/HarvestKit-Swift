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
    
    public init(credential: TSCRequestCredential!) {
        
        requestController.sharedRequestCredential = credential
        requestController.sharedRequestHeaders["Accept"] = "application/json"
        
    }
    
    /**
    Gets a list of all registered users for the given account
    */
    func getUsers(completionHandler: (users: [User]?, requestError: NSError?) -> ()) {
        
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
    
}
