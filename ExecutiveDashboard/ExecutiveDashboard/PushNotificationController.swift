//
//  PushNotificationController.swift
//  ExecutiveDashboard
//
//  Created by maheshbabu.somineni on 7/28/15.
//
//

import UIKit
import Parse

class PushNotificationController: NSObject {
   
    override init() {
        super.init()
    
        
        Parse.setApplicationId(GlobalVariables.x_parse_application_id_value, clientKey:GlobalVariables.parse_client_key)
    }
}
