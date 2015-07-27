//
//  DAO.swift
//  BeBetter
//
//  Created by Ana Carolina Cabral on 21/07/15.
//  Copyright (c) 2015 Ana Carolina Cabral. All rights reserved.
//

import Foundation


private let _DAO = DAO()

class DAO {

    class var sharedInstance: DAO{
        
        return _DAO
    }
    
    func getAcitivitiesForCategory(Category) -> [Activity]{
    
        var activities = [Activity]()
        return activities
    }
    
//    func setChoosenCategory
    
    func saveActivity(activity: Activity) -> Bool
    {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as   NSArray
        let documentsDirectory = paths[0] as! String
        let path = documentsDirectory.stringByAppendingPathComponent("Data.plist")
        let fileManager = NSFileManager.defaultManager()
        
        //check if file exists
        if(!fileManager.fileExistsAtPath(path))
        {
            // If it doesn't, copy it from the default file in the Bundle
            if let bundlePath = NSBundle.mainBundle().pathForResource("Data", ofType: "plist")
            {
                let resultDictionary = NSMutableDictionary(contentsOfFile: bundlePath)
                fileManager.copyItemAtPath(bundlePath, toPath: path, error: nil)
            }
            else
            {
                println("Data.plist not found. Please, make sure it is part of the bundle.")
            }
            
        }
        else
        {
            println("Data.plist already exits at path.")
            // use this to delete file from documents directory
            //fileManager.removeItemAtPath(path, error: nil)
        }
        
        
        var dataActivity : NSMutableDictionary! = NSMutableDictionary(contentsOfFile: path)

        
        dataActivity.setObject(activity.name, forKey: "name")
        dataActivity.setObject(activity.videoTutorial, forKey: "videoTutorial")
        dataActivity.setObject(activity.category, forKey: "category")

        dataActivity.writeToFile(path, atomically: true)

        println(path)
        println(dataActivity)
        
        return true

    }
    
    
    func saveFrequency(frequency: FrequencyActivity) -> Bool
    {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as   NSArray
        let documentsDirectory = paths[0] as! String
        let path = documentsDirectory.stringByAppendingPathComponent("Data.plist")
        let fileManager = NSFileManager.defaultManager()
        
        //check if file exists
        if(!fileManager.fileExistsAtPath(path))
        {
            // If it doesn't, copy it from the default file in the Bundle
            if let bundlePath = NSBundle.mainBundle().pathForResource("Data", ofType: "plist")
            {
                let resultDictionary = NSMutableDictionary(contentsOfFile: bundlePath)
                fileManager.copyItemAtPath(bundlePath, toPath: path, error: nil)
            }
            else
            {
                println("Data.plist not found. Please, make sure it is part of the bundle.")
            }
            
        }
        else
        {
            println("Data.plist already exits at path.")
            // use this to delete file from documents directory
            //fileManager.removeItemAtPath(path, error: nil)
        }
        
        
        var dataFrequency : NSMutableDictionary! = NSMutableDictionary(contentsOfFile: path)
        
        dataFrequency.setObject(frequency.amountWeeks, forKey: "amountWeeks")
        dataFrequency.setObject(frequency.id, forKey: "id")
        dataFrequency.setObject(frequency.daysWithAmountForDay, forKey: "daysWithAmountForDay")
        
        dataFrequency.writeToFile(path, atomically: true)
        
        println(path)
        println(dataFrequency)
        
        return true
        
    }

    
    func deleteActivity(activity: Activity) -> Bool{
     
        return true
    }
    
    func editAcitivity(activity: Activity) -> Bool {
        
        return false
    }
    
    func increaseAmountForDay() -> Bool {
    
        return true
    }

    func increaseWeekAmount() -> Bool {
    
        return false
    }

}
