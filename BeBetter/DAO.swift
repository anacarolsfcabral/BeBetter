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
    
    var currentCategory = String()
    
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
                var id = activityDict.objectForKey("id") as! String
                var category = activityDict.objectForKey("category") as! String
                    
                var newActivity  = Activity(name: name, videoTutorial: videoTutorial, category: category, note: note)
                    
                newActivity.id = "\(i)"
                    
                arrayActivity.append(newActivity)
                    
            }
        }
        
        return arrayActivity
    }
    
    func setChoosenCategory(category: String){
        
        currentCategory = category
        
    }
    
    func getFrequency(arrayActivity: [Activity]) -> [FrequencyActivity] {
        
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as   NSArray
        let documentsDirectory = paths[0] as! String
        let path = documentsDirectory.stringByAppendingPathComponent("Data.plist")
        let fileManager = NSFileManager.defaultManager()
        
        //check if file exists
        println("I'll check if the fucking file exists")
        if(!fileManager.fileExistsAtPath(path))
        {
            // If it doesn't, copy it from the default file in the Bundle
            println("File does not exist. I'll copy it from the bundle")
            if let bundlePath = NSBundle.mainBundle().pathForResource("Data", ofType: "plist")
            {
                println("BundlePath = \(bundlePath)")
                let resultDictionary = NSMutableDictionary(contentsOfFile: bundlePath)
                println("resultDictionary: \(resultDictionary)")
                fileManager.copyItemAtPath(bundlePath, toPath: path, error: nil)
                println("Fuckig file was created...")
            }
            else
            {
                println("Data.plist not found. Please, make sure it is part of the bundle.")
            }
            
        }
        else
        {
            println("Data.plist already exists at path.")
            // use this to delete file from documents directory
            //fileManager.removeItemAtPath(path, error: nil)
        }
        
        
        var root : NSMutableDictionary! = NSMutableDictionary(contentsOfFile: path)
        var frequencyActivity : NSMutableDictionary! = root.objectForKey("FrequencyActivity") as! NSMutableDictionary
        var arrayFrequency = [FrequencyActivity]()
        
        for activity in arrayActivity {
            var frequencyDict = frequencyActivity.objectForKey("FREQUENCY_\(activity.id)") as! NSMutableDictionary
            
            var amountWeeks = frequencyDict.objectForKey("amountWeeks") as! Int
            var daysWithAmountForDay = frequencyDict.objectForKey("daysWithAmountForDay")  as! NSDictionary
            var id = frequencyDict.objectForKey("id") as! String
            
            var newFrequency = FrequencyActivity(amountWeeks: amountWeeks, daysWithAmountForDay: daysWithAmountForDay)
            
            newFrequency.id = "\(activity.id)"
            
            arrayFrequency.append(newFrequency)
        }
        
        return arrayFrequency
    }
    
    func saveActivity(newActivity: Activity, newFrequency: FrequencyActivity)->Bool{
        
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
                println("copying plist...")
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
            println("Data.plist already exits at path - save activity.")
            // use this to delete file from documents directory
            //fileManager.removeItemAtPath(path, error: nil)
        }
        
        
        var root : NSMutableDictionary! = NSMutableDictionary(contentsOfFile: path)
        var activity : NSMutableDictionary! = root.objectForKey("Activity") as! NSMutableDictionary
        
        var numActivity = root.valueForKey("ActivityAmount") as! Int
        println(numActivity)
        
        let newDict = ["name": "\(newActivity.name)","category":"\(newActivity.category)", "id":"\(numActivity)","lastVideo":"\(newActivity.lastVideo)","note": "\(newActivity.note)","videoTutorial":"\(newActivity.videoTutorial)"]
        
        activity.setObject(newDict, forKey: "ACTIVITY_\(numActivity)")
        root.setObject(activity, forKey: "Activity")
        
        
        var frequency : NSMutableDictionary! = root.objectForKey("FrequencyActivity") as! NSMutableDictionary
        let newFreqDict = ["amountWeeks": "\(newFrequency.amountWeeks)","daysWithAmountForDay": newFrequency.daysWithAmountForDay, "id":"\(numActivity)"]
        

        frequency.setObject(newFreqDict, forKey: "FREQUENCY_\(numActivity)")
        root.setObject(frequency, forKey: "FrequencyActivity")
        
        numActivity+=1
        root.setObject(numActivity, forKey: "ActivityAmount")
        
        root.writeToFile(path, atomically: true)
        
        print(root)
        return true
    }
    
//    
//    func saveFrequency(newFrequency: FrequencyActivity){
//        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as   NSArray
//        let documentsDirectory = paths[0] as! String
//        let path = documentsDirectory.stringByAppendingPathComponent("Data.plist")
//        let fileManager = NSFileManager.defaultManager()
//        
//        //check if file exists
//        if(!fileManager.fileExistsAtPath(path))
//        {
//            // If it doesn't, copy it from the default file in the Bundle
//            if let bundlePath = NSBundle.mainBundle().pathForResource("Data", ofType: "plist")
//            {
//                let resultDictionary = NSMutableDictionary(contentsOfFile: bundlePath)
//                fileManager.copyItemAtPath(bundlePath, toPath: path, error: nil)
//            }
//            else
//            {
//                println("Data.plist not found. Please, make sure it is part of the bundle.")
//            }
//            
//        }
//        else
//        {
//            println("Data.plist already exits at path.")
//            // use this to delete file from documents directory
//            //fileManager.removeItemAtPath(path, error: nil)
//        }
//        
//        var root : NSMutableDictionary! = NSMutableDictionary(contentsOfFile: path)
//        var frequency : NSMutableDictionary! = root.objectForKey("FrequencyActivity") as! NSMutableDictionary
//        println(frequency)
//        var numActivity = root.objectForKey("ActivityAmount") as! Int
//        
//        let newDict = ["amountWeeks": "\(newFrequency.amountWeeks)","daysWithAmountForDay": newFrequency.daysWithAmountForDay, "id":"\(numActivity)"]
//        
//        frequency.setObject(newDict, forKey: "FREQUENCY_\(numActivity)")
//        println(frequency)
//        root.writeToFile(path, atomically: true)
//
//    }

    
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
