//
//  Technologies.swift
//  
//
//  Created by maheshbabu.somineni on 7/29/15.
//
//


@objc(Technologies)
class Technologies: NSManagedObject {

    @NSManaged var active: String
    @NSManaged var createdAt: String
    @NSManaged var descr: String
    @NSManaged var name: String
    @NSManaged var objectId: String
    @NSManaged var position: String
    @NSManaged var updatedAt: String

}
