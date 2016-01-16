//
//  ContactsController.swift
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

public class ContactsController {
    
    let requestController: TSCRequestController
    
    internal init(requestController: TSCRequestController) {
        
        self.requestController = requestController
        
    }
    
    public func getContacts(completionHandler: (contacts: [Contact]?, requestError: NSError?) -> ()) {
        
        requestController.get("contacts") { (response: TSCRequestResponse?, requestError: NSError?) -> Void in
            
            if let error = requestError {
                completionHandler(contacts: nil, requestError: error)
                return;
            }
            
            if let contactsArray = response?.array as? [[String: AnyObject]] {
                
                let contacts = contactsArray.map({Contact(dictionary: $0)}).filter { $0 != nil }.map { $0! }
                
                completionHandler(contacts: contacts, requestError: nil)
            }
            
        }
        
    }
    
}