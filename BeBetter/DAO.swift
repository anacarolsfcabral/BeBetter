//
//  DAO.swift
//  BeBetter
//
//  Created by Ana Carolina Cabral on 21/07/15.
//  Copyright (c) 2015 Ana Carolina Cabral. All rights reserved.
//

import Foundation


private let _DAO = DAO()

var currentCategory = String()

class DAO {

    class var sharedInstance: DAO{
        
        
        return _DAO
    }
    
    func getActivitiesForCategory() -> [Activity]{
        
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
            
            
        var root : NSMutableDictionary! = NSMutableDictionary(contentsOfFile: path)
        var allActivity : NSMutableDictionary! = root.objectForKey("Activity") as! NSMutableDictionary
            
            
        var numActivity = root.objectForKey("ActivityAmount") as! Int
        var arrayActivity : [Activity] = [Activity]()
        
        for ( var i = 0; i < numActivity; i++){
            var activityDict = allActivity.objectForKey("ACTIVITY_\(i)") as! NSMutableDictionary
            var activityCategory = activityDict.objectForKey("category") as! NSString
                
            if (activityCategory.isEqualToString(currentCategory))
            {
                    
                var name = activityDict.objectForKey("name") as! String
                var videoTutorial = activityDict.objectForKey("videoTutorial") as! String
                var note = activityDict.objectForKey("note") as! String
                var lastVideo = activityDict.objectForKey("lastVideo") as! String
                var id = activityDict.objectForKey("id") as! Int
                var category = activityDict.objectForKey("category") as! String
                    
                var newActivity  = Activity(name: name, videoTutorial: videoTutorial, category: category, note: note)
                    
                newActivity.id = i
                    
                arrayActivity.append(newActivity)
                    
            }
        }
        
        return arrayActivity
    }
    
    func setChoosenCategory(category: String){
        
        currentCategory = category
        
    }
    
//    func getFrequency(activity: Activity)-> FrequencyActivity {
//        
//    }
    
    func saveActivity(newActivity: Activity, frequencyActivity: FrequencyActivity)->Bool{
        
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
                return false
            }
            
        }
        else
        {
            println("Data.plist already exits at path.")
            // use this to delete file from documents directory
            //fileManager.removeItemAtPath(path, error: nil)
        }
        
        
        var root : NSMutableDictionary! = NSMutableDictionary(contentsOfFile: path)
        var activity : NSMutableDictionary! = root.objectForKey("Activity") as! NSMutableDictionary
        
        var numActivity = root.objectForKey("ActivityAmount") as! Int
    
        let newDict = ["name": "\(newActivity.name)","category":"\(newActivity.category)", "id":"\(numActivity)","lastVideo":"\(newActivity.lastVideo)","note": "\(newActivity.note)","videoTutorial":"\(newActivity.videoTutorial)"]
        
        activity.setObject(newDict, forKey: "ACTIVITY_\(numActivity)")
        
        saveFrequency(frequencyActivity)
        
        println(root)
        
        root.setObject((numActivity + 1), forKey: "ActivityAmount")
        root.writeToFile(path, atomically: true)
        
        return true
    }
    
    
    func saveFrequency(newFrequency: FrequencyActivity){
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
        
        var root : NSMutableDictionary! = NSMutableDictionary(contentsOfFile: path)
        var frequency : NSMutableDictionary! = root.objectForKey("FrequencyActivity") as! NSMutableDictionary
        
        var numActivity = root.objectForKey("ActivityAmount") as! Int
        
        let newDict = ["amountWeeks": "\(newFrequency.amountWeeks)","daysWithAmountForDay":"\(newFrequency.daysWithAmountForDay)", "id":"\(numActivity)"]
        
        frequency.setObject(newDict, forKey: "FREQUENCY_\(numActivity)")
        
        root.writeToFile(path, atomically: true)

    }

    
    func deleteActivity(newActivity: Activity) -> Bool{
        
        return true
    }
    
    
    func increaseAmountForDay() -> Bool {
    
        return true
    }

    func increaseWeekAmount() -> Bool {
    
        return false
    }

}
