//
//  ProjectsController.swift
//  HarvestKit
//
//  Created by Matthew Cheetham on 01/08/2016.
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
 Handles loading information about projects from the Harvest API
 */
public final class ProjectsController {
    
    /**
     The request controller used to load project information. This is shared with other controllers
     */
    public let requestController: TSCRequestController
    
    internal init(requestController: TSCRequestController) {
        
        self.requestController = requestController
        
    }
    
    /**
     Gets projects for the account
     
     - parameters:
     - completionHandler: The completion handler to return projects and errors to
     */
    public func getProjects(completionHandler: (projects: [Project?]?, requestError: NSError?) -> ()) {
        
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
}