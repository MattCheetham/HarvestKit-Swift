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

/**
The contacts controller is responsible for managing contacts in the Harvest API. Contacts can be assosciated with clients
*/
public final class ContactsController {
    
    /**
    The request controller used to load contact information. This is shared with other controllers
    */
    let requestController: TSCRequestController
    
    /**
    Initialises a new controller.
    - parameter requestController: The request controller to use when loading contact information. This must be passed down from HarvestController so that authentication may be shared
    */
    internal init(requestController: TSCRequestController) {
        
        self.requestController = requestController
    }
    
    //MARK: - Creating Contacts
    
    /**
    Creates a new contact entry in the Harvest system. You may configure any of the parameters on the contact object you are creating and they will be saved.
    
    - parameter contact: The new contact object to send to the API
    - parameter completionHandler: The completion handler to return any errors to
    
    - requires: `clientIdentifier`, `firstName` and `lastName` on the contact object as a minimum
    */
    public func create(contact: Contact, completionHandler: (requestError: NSError?) -> ()) {
        
        guard let _ = contact.clientIdentifier else {
            
            let error = NSError(domain: "co.uk.mattcheetham.harvestkit", code: 400, userInfo: [NSLocalizedDescriptionKey: "Contact does not have a client identifier"])
            completionHandler(requestError: error)
            return
        }
        
        guard let _ = contact.firstName else {
            
            let error = NSError(domain: "co.uk.mattcheetham.harvestkit", code: 400, userInfo: [NSLocalizedDescriptionKey: "Contact does not have a first name"])
            completionHandler(requestError: error)
            return
        }
        
        guard let _ = contact.lastName else {
            
            let error = NSError(domain: "co.uk.mattcheetham.harvestkit", code: 400, userInfo: [NSLocalizedDescriptionKey: "Contact does not have a last name"])
            completionHandler(requestError: error)
            return
        }
        
        requestController.post("contacts", bodyParams: contact.serialisedObject) { (response: TSCRequestResponse?, requestError: NSError?) -> Void in
            
            if let error = requestError {
                completionHandler(requestError: error)
                return
            }
            
            completionHandler(requestError: nil)
            
        }
        
    }
    
    //MARK: - Retrieving Contacts
    
    /**
    Gets all contacts for the account of the authenticated user.
     
    - parameter completionHandler: The completion handler to return contacts and errors to
     
    - Note: The user must have access to the contacts on this account
    */
    public func getContacts(completionHandler: (contacts: [Contact]?, requestError: NSError?) -> ()) {
        
        requestController.get("contacts") { (response: TSCRequestResponse?, requestError: NSError?) -> Void in
            
            if let error = requestError {
                completionHandler(contacts: nil, requestError: error)
                return;
            }
            
            if let contactsArray = response?.array as? [[String: AnyObject]] {
                
                let contacts = contactsArray.map({Contact(dictionary: $0)}).filter { $0 != nil }.map { $0! }
                
                completionHandler(contacts: contacts, requestError: nil)
                return
            }
            
            let error = NSError(domain: "co.uk.mattcheetham.harvestkit", code: 500, userInfo: [NSLocalizedDescriptionKey: "The server did not return a valid response"])
            completionHandler(contacts: nil, requestError: error)
            
        }
        
    }
    
    /**
     Gets all contacts assosciated with a client by their identifier
     
     - parameter clientIdentifier: The unique identifier of the client to search for contacts for
     - parameter completionHandler: The completion handler to return contacts and errors to
     
     - Note: The user must have access to the contacts on this account
     */
    public func getContacts(clientIdentifier: Int, completionHandler: (contacts: [Contact]?, requestError: NSError?) -> ()) {
        
        requestController.get("clients/\(clientIdentifier)/contacts") { (response: TSCRequestResponse?, requestError: NSError?) -> Void in
            
            if let error = requestError {
                completionHandler(contacts: nil, requestError: error)
                return;
            }
            
            if let contactsArray = response?.array as? [[String: AnyObject]] {
                
                let contacts = contactsArray.map({Contact(dictionary: $0)}).filter { $0 != nil }.map { $0! }
                
                completionHandler(contacts: contacts, requestError: nil)
                return
            }
            
            let error = NSError(domain: "co.uk.mattcheetham.harvestkit", code: 500, userInfo: [NSLocalizedDescriptionKey: "The server did not return a valid response"])
            completionHandler(contacts: nil, requestError: error)
            
        }
        
    }
    
    /**
     Gets all contacts assosciated with a client
     
     - parameter clientIdentifier: The unique identifier of the client to search for contacts for
     - parameter completionHandler: The completion handler to return contacts and errors to
     
     - Note: The user must have access to the contacts on this account
     */
    public func getContacts(client: Client, completionHandler: (contacts: [Contact]?, requestError: NSError?) -> ()) {
        
        guard let clientIdentifier = client.identifier else {
            
            let error = NSError(domain: "co.uk.mattcheetham.harvestkit", code: 400, userInfo: [NSLocalizedDescriptionKey: "The client specified does not have an identifier"])
            completionHandler(contacts: nil, requestError: error)
            return
        }
        
        getContacts(clientIdentifier, completionHandler: completionHandler)
        
    }
    
    /**
     Gets a contact for a specific ID
     
     - parameter identifier: The identifier for a contact
     - parameter completionHandler: The completion handler to return the contact and errors to
     */
    public func getContact(identifier: Int, completionHandler: (contact: Contact?, requestError: NSError?) -> ()) {
        
        requestController.get("contacts/\(identifier)") { (response: TSCRequestResponse?, requestError: NSError?) -> Void in
            
            if let error = requestError {
                completionHandler(contact: nil, requestError: error)
                return
            }
            
            if let contactResponse = response {
                
                if let contactResponseDictionary = contactResponse.dictionary as? [String: AnyObject] {
                    
                    let foundContact = Contact(dictionary: contactResponseDictionary)
                    completionHandler(contact: foundContact, requestError: nil)
                    return
                    
                }
                
            }
            
            let error = NSError(domain: "co.uk.mattcheetham.harvestkit", code: 500, userInfo: [NSLocalizedDescriptionKey: "The server did not return a valid contact object"])
            completionHandler(contact: nil, requestError: error)
            
        }
        
    }
    
    //MARK: - Modifying Contacts
    
    /**
    Updates a contact. The contact must have an identifier to be updated. All other properties will be updated in the system except for creation and update date which are fixed.
    
    - parameter contact: The contact to update. You may modify a contact returned from another request or create a new one that has a valid identifier
    - parameter completionHandler: The completion handler to return request errors to
    */
    public func update(contact: Contact, completionHandler: (requestError: NSError?) -> ()) {
        
        guard let contactIdentifier = contact.identifier else {
            let error = NSError(domain: "co.uk.mattcheetham.harvestkit", code: 400, userInfo: [NSLocalizedDescriptionKey: "Supplied contact does not have an identifier"])
            completionHandler(requestError: error)
            return;
        }
        
        requestController.put("contacts/\(contactIdentifier)", bodyParams: contact.serialisedObject) { (response: TSCRequestResponse?, requestError: NSError?) -> Void in
            
            if let error = requestError {
                completionHandler(requestError: error)
                return
            }
            
            completionHandler(requestError: nil)
        }
        
    }
    
    /**
     Deletes the given contact. Will return an error of 404 if the timer has already been deleted or is not valid
     
     - parameter contact: The contact to delete
     - parameter completionHandler: The completion handler to return request errors to
     */
    public func delete(contact: Contact, completionHandler: (requestError: NSError?) -> ()) {
        
        guard let contactIdentifier = contact.identifier else {
            let error = NSError(domain: "co.uk.mattcheetham.harvestkit", code: 400, userInfo: [NSLocalizedDescriptionKey: "Contact does not have an identifier"])
            completionHandler(requestError: error)
            return;
        }
        
        requestController.delete("contacts/\(contactIdentifier)") { (resposne: TSCRequestResponse?, requestError: NSError?) -> Void in

            if let error = requestError {
                completionHandler(requestError: error)
                return;
            }
            
            completionHandler(requestError: nil)
            
        }
        
    }
    
}