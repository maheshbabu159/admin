//
//  Project.swift
//  
//
//  Created by maheshbabu.somineni on 8/6/15.
//
//

import Foundation
import CoreData

class Project: NSManagedObject {

    @NSManaged var class_name: String
    @NSManaged var createdAt: String
    @NSManaged var objectId: String
    @NSManaged var clientLocation: String
    @NSManaged var clientName: String
    @NSManaged var type: String
    @NSManaged var updatedAt: String
    @NSManaged var department: String
    @NSManaged var name: String
    @NSManaged var state: String
    @NSManaged var status: String
    @NSManaged var programManagerId: String
    @NSManaged var projectManagerId: String
    @NSManaged var deliveryHeadId: String

}
