//
//  RevenueModel.swift
//  GameFramework
//
//  Created by maheshbabu.somineni on 6/25/15.
//  Copyright (c) 2015 apple. All rights reserved.
//

import UIKit

class RevenueModel: Revenue {
   
    //Method to parse dictionary and save it in database
    class func initWithDictionary(aDictionary:NSDictionary){
        
        //Creating managed object to save in database
   
        //Convert dictionary values to managed data object.
        if let resultArray = aDictionary["result"] as? NSArray{
            
            for resultDictionary in resultArray {
             
                let object = Revenue.MR_createEntity() as Revenue
                
                if let type = resultDictionary["__type"] as? NSString {
                    
                    object.type = type as String
                    
                }
                if let className:NSString = resultDictionary["className"] as? NSString {
                    
                    object.class_name = className as String
                    
                }
                if let amount:Int = resultDictionary["amount"] as? Int {
                    
                    object.amount = "\(amount)"
                    
                }
                if let objectId:NSString = resultDictionary["objectId"] as? NSString {
                    
                    object.objectId = objectId as String
                    
                }
                
                if let createdAt:NSString = resultDictionary["createdAt"] as? NSString {
                    
                    object.createdAt = createdAt as String
                    
                }
                if let month:Int = resultDictionary["month"] as? Int {
                    
                    object.month = "\(month)"
                    
                    
                }
                if let updatedAt:NSString = resultDictionary["updatedAt"] as? NSString {
                    
                    object.updatedAt = updatedAt as String
                    
                    
                }
                if let year:Int = resultDictionary["year"] as? Int {
                    
                    object.year = "\(year)"
                    
                }
            }
            

        }

        //Save changes to database
        NSManagedObjectContext.MR_defaultContext().MR_saveToPersistentStoreAndWait()
    }
    //Method to get all the objects from database
    class func getAllRevenueObjects() -> NSArray{
        
        let array =  Revenue.MR_findAll() as NSArray
        
        return array
        
    }
    //Method to delete all the objects from database
    class func deleteAllRevenueObjects(){
        
        Revenue.MR_truncateAll()
        
        //Save changes to database
        NSManagedObjectContext.MR_defaultContext().MR_saveToPersistentStoreAndWait()
    
    }
    
    //Method to get total of visits all the objects from database
    class func getRevenueTotal()->Int{
        
        var totalCount:Int = 0
        if let array =  Revenue.MR_findAll() as? [Revenue]{
            
            for item:Revenue in array {
                
                
                totalCount = totalCount + item.amount.toInt()!
                
            }
            
        }
        return totalCount
        
    }
    //Method to get total of visits all the objects from database
    class func getRevenueArrayCount()->Int{
        
        let array:NSArray =  Revenue.MR_findAll() as! [Revenue]!
        
        return array.count
        
    }
}