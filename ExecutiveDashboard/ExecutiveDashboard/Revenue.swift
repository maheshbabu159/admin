//
//  Revenue.swift
//  GameFramework
//
//  Created by maheshbabu.somineni on 6/29/15.
//  Copyright (c) 2015 apple. All rights reserved.
//


@objc(Revenue)
class Revenue: NSManagedObject {

    @NSManaged var amount: String
    @NSManaged var class_name: String
    @NSManaged var createdAt: String
    @NSManaged var month: String
    @NSManaged var objectId: String
    @NSManaged var type: String
    @NSManaged var updatedAt: String
    @NSManaged var year: String

}
