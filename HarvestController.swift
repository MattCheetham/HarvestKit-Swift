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
    
}
