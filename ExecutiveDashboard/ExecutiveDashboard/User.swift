//
//  User.swift
//  ExecutiveDashboard
//
//  Created by maheshbabu.somineni on 8/6/15.
//
//

//

@objc(User)
class User: NSManagedObject {

    @NSManaged var active: String
    @NSManaged var address: String
    @NSManaged var associateId: String
    @NSManaged var birthDate_iso: String
    @NSManaged var birthDate_type: String
    @NSManaged var bloodGroup: String
    @NSManaged var class_name: String
    @NSManaged var createdAt: String
    @NSManaged var createdBy: String
    @NSManaged var department: String
    @NSManaged var designation: String
    @NSManaged var email: String
    @NSManaged var firstname: String
    @NSManaged var gender: String
    @NSManaged var grade: String
    @NSManaged var joinDate_iso: String
    @NSManaged var joinDate_type: String
    @NSManaged var lastname: String
    @NSManaged var maritalStatus: String
    @NSManaged var objectId: String
    @NSManaged var phone: String
    @NSManaged var photo_name: String
    @NSManaged var photo_type: String
    @NSManaged var photo_url: String
    @NSManaged var reportingTo: String
    @NSManaged var roleId: String
    @NSManaged var roleName: String
    @NSManaged var type: String
    @NSManaged var updatedAt: String
    @NSManaged var userId: String
    @NSManaged var username: String

}
