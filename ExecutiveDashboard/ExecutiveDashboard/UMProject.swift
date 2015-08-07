//
//  UMProject.swift
//  ExecutiveDashboard
//
//  Created by maheshbabu.somineni on 8/7/15.
//
//

import Foundation

class UMProject: NSObject {
    
    var class_name: String = ""
    var createdAt: String = ""
    var objectId: String = ""
    var clientLocation: String = ""
    var clientName: String = ""
    var type: String = ""
    var updatedAt: String = ""
    var department: String = ""
    var startDate: String = ""
    var name: String = ""
    var state: String = ""
    var status: String = ""
    var programManagerDictionary: Dictionary<String, AnyObject>?
    var projectManagerDictionary:Dictionary<String, AnyObject>?
    var deliveryHeadDictionary:Dictionary<String, AnyObject>?
}
