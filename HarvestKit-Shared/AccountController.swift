//
//  AccountController.swift
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
Handles loading information about the currently authenticated user
*/
public final class AccountController {
    
    /**
     The request controller used to load account information. This is shared with other controllers
     */
    let requestController: TSCRequestController
    
    internal init(requestController: TSCRequestController) {
        
        self.requestController = requestController
        
    }
    
    /**
    Retrieves a user and a company object for the currently authenticated user.
    
    - parameter completionHandler: The completion handler to call passing a company and user object if available. This may also be passed an error object where appropriate
    */
    public func getAccountInformation(completionHandler: (currentUser: User?, currentCompany: Company?, requestError: NSError?) -> ()) {
     
        requestController.get("account/who_am_i") { (response: TSCRequestResponse?, requestError: NSError?) -> Void in
            
            if let error = requestError {
                completionHandler(currentUser: nil, currentCompany: nil, requestError: error)
                return;
            }
            
            guard let responseDictionary = response?.dictionary as? [String: AnyObject] else {
                completionHandler(currentUser: nil, currentCompany: nil, requestError: nil)
                return;
            }
            
            var responseCompany: Company?
            var responseUser: User?
            
            if let companyDictionary = responseDictionary["company"] as? [String: AnyObject] {
                responseCompany = Company(dictionary: companyDictionary)
            }
            
            if let userDictionary = responseDictionary["user"] as? [String: AnyObject] {
                responseUser = User(dictionary: userDictionary)
            }
            
            completionHandler(currentUser: responseUser, currentCompany: responseCompany, requestError: nil)
            
        }
        
    }

}