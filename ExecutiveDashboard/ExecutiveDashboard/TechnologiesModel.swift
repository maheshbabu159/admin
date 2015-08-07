//
//  PlatformModel.swift
//  ExecutiveDashboard
//
//  Created by maheshbabu.somineni on 7/29/15.
//
//

import UIKit

class TechnologiesModel: Technologies {
  
    //Method to parse dictionary and save it in database
    class func initWithDictionary(aDictionary:NSDictionary){
        
        //Convert dictionary values to managed data object.
        if let resultArray = aDictionary["results"] as? NSArray{
            
            for resultDictionary in resultArray {
                
                //Creating managed object to save in database
                let object = Technologies.MR_createEntity() as Technologies
                

                if let objectId:NSString = resultDictionary["objectId"] as? NSString {
                    
                    object.objectId = objectId as String
                    
                }
                if let createdAt:NSString = resultDictionary["createdAt"] as? NSString {
                    
                    object.createdAt = createdAt as String
                    
                }
                if let updatedAt:NSString = resultDictionary["updatedAt"] as? NSString {
                    
                    object.updatedAt = updatedAt as String
                    
                    
                }
                if let name:NSString = resultDictionary["name"] as? NSString {
                    
                    object.name = name as String
                    
                }
                if let descr:NSString = resultDictionary["description"] as? NSString {
                    
                    object.descr = descr as String
                    
                }
            }
            
        }
        
        
        //Save changes to database
        NSManagedObjectContext.MR_defaultContext().MR_saveToPersistentStoreAndWait()
    }
    //Method to delete all the objects from database
    class func getAllObjects() -> NSArray{

        let array =  Technologies.MR_findAll() as NSArray
        
        return array
        
    }
    //Method to delete all the objects from database
    class func deleteAllObjects(){
        
        Technologies.MR_truncateAll()
        
        //Save changes to database
        NSManagedObjectContext.MR_defaultContext().MR_saveToPersistentStoreAndWait()
        
    }
}
