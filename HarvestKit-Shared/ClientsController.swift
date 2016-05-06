//
//  ClientController.swift
//  HarvestKit
//
//  Created by Matthew Cheetham on 06/05/2016.
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

/** The client controller is responsible for adding, deleting and updating client information with the Harvest API. This controller will only work if your account has the client module enabled
 */
public final class ClientsController {
    
    /**
     The request controller used to load contact information. This is shared with other controllers
     */
    let requestController: TSCRequestController
    
    /**
     Initialises a new controller.
     - parameter requestController: The request controller to use when loading client information. This must be passed down from HarvestController so that authentication may be shared
     */
    internal init(requestController: TSCRequestController) {
        
        self.requestController = requestController
    }
}