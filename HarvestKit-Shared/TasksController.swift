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
    
    public var tasks: [Task]?
    
    internal init(requestController: TSCRequestController) {
        
        self.requestController = requestController
        getTasks { (tasks, requestError) in
            
            if let _tasks = tasks {
                self.tasks = _tasks.flatMap({$0})
            }
            
        }
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
     Gets tasks assignments that are assigned to a project
     
     - param project: The project to look up assigned task assignments for
     - param completionHandler: The completion handler to return tasks and errors to
     */
    public func getTaskAssignments(project: Project, completionHandler: (tasks: [TaskAssignment?]?, requestError: NSError?) -> ()) {
        
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
                    TaskAssignment(dictionary: $0)
                })
                
                completionHandler(tasks: tasks, requestError: nil)
            }
        }
    }
    
    /**
     Finds the task object for a task assignment object that is returned from asking a project for it's tasks
     */
    public func taskFor(taskAssignment: TaskAssignment) -> Task? {
        
        guard let _tasks = tasks else {
            return nil
        }
        
        return _tasks.filter({$0.identifier == taskAssignment.identifier}).first
    }
}