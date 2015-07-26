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
    
    func saveActivity(activity: Activity, frequency: FrequencyActivity) -> Bool
    {
        var pathAux = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String
        var path = pathAux.stringByAppendingPathComponent("Data.plist")
        var fileManager = NSFileManager.defaultManager()
        
        if (!fileManager.fileExistsAtPath(path))
        {
            var bundle : NSString = NSBundle.mainBundle().pathForResource("Data", ofType: "plist")!
            fileManager.copyItemAtPath(bundle as String, toPath: path, error:nil)
            println("copy")
        }
        
        var data : NSMutableDictionary! = NSMutableDictionary(contentsOfFile: path)

        data.setObject(activity.name, forKey: "name")
        data.setObject(activity.videoTutorial, forKey: "videoTutorial")
        data.setObject(activity.category, forKey: "category")

        data.setObject(frequency.amountWeeks, forKey: "amountWeeks")
        data.setObject(frequency.id, forKey: "id")
        data.setObject(frequency.daysWithAmountForDay, forKey: "daysWithAmountForDay")

        data.writeToFile(path, atomically: true)
        println(path)
        println(data)
        
        return true
        
//        if (!fileManager.fileExistsAtPath(path))
//        {
//            let created = fileManager.createFileAtPath(path, contents: nil, attributes: nil)
//            var bundle : NSString! = NSBundle.mainBundle().pathForResource("Data", ofType: "plist")
//
//            if(created)
//            {
//                fileManager.copyItemAtPath(bundle as String, toPath: path, error:nil)
//                println("copy")
//                
//                var data : NSMutableDictionary! = NSMutableDictionary(contentsOfFile: path)
//                
//                data.setObject(activity.name, forKey: "name")
//                data.setObject(activity.videoTutorial, forKey: "videoTutorial")
//                data.setObject(activity.category, forKey: "category")
//                
//                data.setObject(frequency.amountWeeks, forKey: "amountWeeks")
//                data.setObject(frequency.id, forKey: "id")
//                data.setObject(frequency.daysWithAmountForDay, forKey: "daysWithAmountForDay")
//                
//                data.writeToFile(path, atomically: true)
//                println(path)
//                println(data)
//                
//                return true
//            }
//            else
//            {
//                println("Data.plist not created")
//            }
//        }
//        else
//        {
//            println("Data.plist already exits at path.")
//            
//            var data : NSMutableDictionary! = NSMutableDictionary(contentsOfFile: path)
//            
//            data.setObject(activity.name, forKey: "name")
//            data.setObject(activity.videoTutorial, forKey: "videoTutorial")
//            data.setObject(activity.category, forKey: "category")
//            
//            data.setObject(frequency.amountWeeks, forKey: "amountWeeks")
//            data.setObject(frequency.id, forKey: "id")
//            data.setObject(frequency.daysWithAmountForDay, forKey: "daysWithAmountForDay")
//            
//            data.writeToFile(path, atomically: true)
//            
//            println(path)
//            println(data)
//            
//            return true
//        }

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
