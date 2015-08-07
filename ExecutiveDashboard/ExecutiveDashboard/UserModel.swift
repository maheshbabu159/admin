//
//  ProfileModel.swift
//  GameFramework
//
//  Created by maheshbabu.somineni on 6/25/15.
//  Copyright (c) 2015 apple. All rights reserved.
//

import UIKit

class UserModel: User {
    
    //Method to parse dictionary and save it in database
    class func initWithDictionary(aDictionary:NSDictionary){
        
        //Convert dictionary values to managed data object.
        if let resultArray = aDictionary["result"] as? NSArray{
            
            for resultDictionary in resultArray {
                
                
                //Creating managed object to save in database
                let object = User.MR_createEntity() as User
                
                
                if let type = resultDictionary["__type"] as? NSString {
                    
                    object.type = type as String;
                    
                }
                if let active:Bool = resultDictionary["active"] as? Bool {
                    
                    let status = active as NSNumber
                    object.active = status.stringValue;
                    
                }
                if let address:NSString = resultDictionary["address"] as? NSString {
                    
                    object.address = address as String;
                    
                }
                if let associateId:NSString = resultDictionary["associateId"] as? NSString {
                    
                    object.associateId = associateId as String;
                    
                }
                if let birthDictionary:NSDictionary = resultDictionary["birthDate"] as? NSDictionary {
                    
                    if let birthType:NSString = birthDictionary["__type"] as? NSString {
                        
                        object.birthDate_type = birthType as String;
                        
                    }
                    if let birthISO:NSString = birthDictionary["iso"] as? NSString {
                        
                        object.birthDate_iso = birthISO as String;
                        
                    }
                    
                }
                if let bloodGroup:NSString = resultDictionary["bloodGroup"] as? NSString {
                    
                    object.bloodGroup = bloodGroup as String;
                    
                }
                if let className:NSString = resultDictionary["className"] as? NSString {
                    
                    object.class_name = className as String;
                    
                    
                }
                if let createdAt:NSString = resultDictionary["createdAt"] as? NSString {
                    
                    object.createdAt = createdAt as String;
                    
                    
                }
                if let createdBy:NSString = resultDictionary["createdBy"] as? NSString {
                    
                    object.createdBy =  createdBy as String;
                    
                }
                if let department:NSString = resultDictionary["department"] as? NSString {
                    
                    object.department = department as String;
                    
                }
                if let designation:NSString = resultDictionary["designation"] as? NSString {
                    
                    object.designation = designation as String;
                    
                }
                if let email:NSString = resultDictionary["email"] as? NSString {
                    
                    object.email = email as String;
                    
                }
                if let firstname:NSString = resultDictionary["firstname"] as? NSString {
                    
                    object.firstname = firstname as String;
                    
                }
                if let gender:NSString = resultDictionary["gender"] as? NSString {
                    
                    object.gender = gender as String;
                    
                }
                if let grade:NSString = resultDictionary["grade"] as? NSString {
                    
                    object.grade = grade as String;
                    
                }
                if let joinDateDictionary:NSDictionary = resultDictionary["joinDate"] as? NSDictionary {
                    
                    if let joinDateType:NSString = joinDateDictionary["__type"] as? NSString {
                        
                        object.joinDate_type = joinDateType as String;
                        
                    }
                    if let joinDate_iso:NSString = joinDateDictionary["iso"] as? NSString {
                        
                        object.joinDate_iso = joinDate_iso as String;
                        
                    }
                }
                if let lastname:NSString = resultDictionary["lastname"] as? NSString {
                    
                    object.lastname = lastname as String;
                    
                    
                }
                if let maritalStatus:NSString = resultDictionary["maritalStatus"] as? NSString {
                    
                    object.maritalStatus = maritalStatus as String;
                    
                }
                if let objectId:NSString = resultDictionary["objectId"] as? NSString {
                    
                    object.objectId = objectId as String;
                    
                    
                }
                if let phoneNumber:NSString = resultDictionary["phoneNumber"] as? NSString {
                    
                    object.phone = phoneNumber as String;
                    
                    
                }
                if let photoDictionary:NSDictionary = resultDictionary["photo"] as? NSDictionary {
                    
                    
                    if let photoType:NSString = photoDictionary["__type"] as? NSString {
                        
                        object.photo_type = photoType as String;
                        
                    }
                    if let photo_name:NSString = photoDictionary["name"] as? NSString {
                        
                        object.photo_name = photo_name as String;
                        
                    }
                    if let photo_url:NSString = photoDictionary["url"] as? NSString {
                        
                        object.photo_url = photo_url as String;
                        
                    }
                    
                }
                if let role:NSDictionary = resultDictionary["role"] as? NSDictionary {
                    
                    
                    if let objectId:NSString = role["objectId"] as? NSString {
                        
                        object.roleId = objectId as String;
                        
                    }
                    if let roleName:NSString = role["name"] as? NSString {
                        
                        object.roleName = roleName as String;
                        
                        //Update role name here
                        GlobalSettings.updateRoleNameDefaultValue(roleName)
                        
                    }
                    
                }
                if let reportingTo:NSString = resultDictionary["reportingTo"] as? NSString {
                    
                    object.reportingTo = reportingTo as String;
                    
                    
                }
                if let username:NSString = resultDictionary["username"] as? NSString {
                    
                    object.username = username as String;
                    
                    
                }
                if let updatedAt:NSString = resultDictionary["updatedAt"] as? NSString {
                    
                    object.updatedAt =  updatedAt as String;
                    
                }
                if let userId:NSString = resultDictionary["userId"] as? NSString {
                    
                    object.userId = userId as String;
                    
                    
                }
            }
        }
        
        //End of parsing dictionary
        NSManagedObjectContext.MR_defaultContext().MR_saveToPersistentStoreAndWait()
        
    }
    //Method to delete all the objects from database
    class func deleteAllObjects(){
        
        
        User.MR_truncateAll()
        NSManagedObjectContext.MR_defaultContext().MR_saveToPersistentStoreAndWait()
        
    }
    //Method to delete all the objects from database
    class func getAllObjects() -> NSArray {
        
        let profilesArray = User.MR_findAll() as NSArray
        
        return profilesArray
    }
    
}
