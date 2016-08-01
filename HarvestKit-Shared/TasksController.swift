//
//  TasksController.swift
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
 Handles loading information about tasks that can be used on projects from the Harvest API
 */
public final class TasksController {
    
    /**
     The request controller used to load task information. This is shared with other controllers
     */
    public let requestController: TSCRequestController
    
    internal init(requestController: TSCRequestController) {
        
        self.requestController = requestController
        
    }
    
    /**
     Gets tasks for the account
     
     - parameters:
     - completionHandler: The completion handler to return tasks and errors to
     */
    public func getTasks(completionHandler: (tasks: [Task?]?, requestError: NSError?) -> ()) {
        
        requestController.get("tasks") { (response: TSCRequestResponse?, requestError: NSError?) -> Void in
            
            if let error = requestError {
                completionHandler(tasks: nil, requestError: error)
                return;
            }
            
            if let tasksArray = response?.array as? [[String: AnyObject]] {
                
                let tasks = tasksArray.map({
                    Task(dictionary: $0)
                })
                
                completionHandler(tasks: tasks, requestError: nil)
            }
        }
    }
    
    /**
     Gets tasks that are assigned to a project
     
     - param project: The project to look up assigned tasks for
     - param completionHandler: The completion handler to return tasks and errors to
     */
    public func getTasks(project: Project, completionHandler: (tasks: [Task?]?, requestError: NSError?) -> ()) {
        
        guard let projectId = project.identifier else {
            completionHandler(tasks: nil, requestError: nil)
            return
        }
        
        requestController.get("projects/\(projectId)/task_assignments") { (response: TSCRequestResponse?, requestError: NSError?) -> Void in
            
            if let error = requestError {
                completionHandler(tasks: nil, requestError: error)
                return;
            }
            
            if let tasksArray = response?.array as? [[String: AnyObject]] {
                
                let tasks = tasksArray.map({
                    Task(dictionary: $0)
                })
                
                completionHandler(tasks: tasks, requestError: nil)
            }
        }
    }
}