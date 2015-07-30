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
    let savedInformation = NSUserDefaults.standardUserDefaults()
    var currentActivityId = String()
    
    func setcurrentActivity(activity: Activity){
        currentActivityId = activity.id
    }
    
    func getCurrentAcivity()-> Activity{
        var activityDict = savedInformation.objectForKey("ACTIVITY_\(currentActivityId)") as! NSMutableDictionary
        
        var name = activityDict.objectForKey("name") as! String
        var videoTutorial = activityDict.objectForKey("videoTutorial") as! String
        var note = activityDict.objectForKey("note") as! String
        var lastVideo = activityDict.objectForKey("lastVideo") as! String
        var id = activityDict.objectForKey("id") as! String
        var category = activityDict.objectForKey("category") as! String
        
        var newActivity  = Activity(name: name, videoTutorial: videoTutorial, category: category, note: note)
        
        newActivity.id = currentActivityId

        return newActivity
    }
    
    func getCurrentFrequency()-> FrequencyActivity{
        
        var frequencyDict = savedInformation.objectForKey("FREQUENCY_\(currentActivityId)") as! NSMutableDictionary
        
        var amountWeeks = frequencyDict.objectForKey("amountWeeks") as! Int
        var daysWithAmountForDay = frequencyDict.objectForKey("daysWithAmountForDay")  as! NSMutableDictionary
        var id = frequencyDict.objectForKey("id") as! String
        var selectedDaysCount = frequencyDict.objectForKey("selectedDaysCount") as! Int
        var newFrequency = FrequencyActivity(amountWeeks: amountWeeks, daysWithAmountForDay: daysWithAmountForDay, selectedDaysCount: selectedDaysCount)
        
        newFrequency.id = id
        
        
        return newFrequency
    }
    
    func getCurrentPerformance()-> PerformanceForWeek{
        
        var performanceDict = savedInformation.objectForKey("PERFORMANCE_\(currentActivityId)") as! NSMutableDictionary
        
        var amountWeeks = performanceDict.objectForKey("numberWeek") as! Int
        var daysWithAmountForDay = performanceDict.objectForKey("daysWithAmountForDay")  as! NSMutableDictionary
        var id = performanceDict.objectForKey("id") as! String
        
        var completed = performanceDict.objectForKey("completed") as! Int
        
        var newPerformance = PerformanceForWeek(numberWeek: amountWeeks, daysWithAmountForDay: daysWithAmountForDay, completed: completed)
        newPerformance.id = id
        
        return newPerformance

    }
    
    func getActivitiesForCategory() -> [Activity]{
   
        var numActivity = savedInformation.integerForKey("ActivityAmount")
        
        var arrayActivity : [Activity] = [Activity]()
        
        for ( var i = 0; i < numActivity; i++){
            var activityDict = savedInformation.objectForKey("ACTIVITY_\(i)") as! NSMutableDictionary
            var activityCategory = activityDict.objectForKey("category") as! NSString
                
            if (activityCategory.isEqualToString(currentCategory)){
                var name = activityDict.objectForKey("name") as! String
                var videoTutorial = activityDict.objectForKey("videoTutorial") as! String
                var note = activityDict.objectForKey("note") as! String
                var lastVideo = activityDict.objectForKey("lastVideo") as! String
                var id = activityDict.objectForKey("id") as! String
                var category = activityDict.objectForKey("category") as! String
                var newActivity  = Activity(name: name, videoTutorial: videoTutorial, category: category, note: note)
                
                newActivity.id = id
                arrayActivity.append(newActivity)
            }
        }
        return arrayActivity
    }
    
    func getActivitiesThatHaveNote()-> [Activity]{
        
        var numActivity = savedInformation.integerForKey("ActivityAmount")
        
        var arrayActivity : [Activity] = [Activity]()
        
        for ( var i = 0; i < numActivity; i++){
            var activityDict = savedInformation.objectForKey("ACTIVITY_\(i)") as! NSMutableDictionary
            var note = activityDict.objectForKey("note") as! NSString
            
            if (note != "" ){
                var name = activityDict.objectForKey("name") as! String
                var videoTutorial = activityDict.objectForKey("videoTutorial") as! String
                var note = activityDict.objectForKey("note") as! String
                println(note)
                var lastVideo = activityDict.objectForKey("lastVideo") as! String
                var id = activityDict.objectForKey("id") as! String
                var category = activityDict.objectForKey("category") as! String
                var newActivity  = Activity(name: name, videoTutorial: videoTutorial, category: category, note: note)
                
                newActivity.id = id
                arrayActivity.append(newActivity)
            }
        }
        return arrayActivity
    }
    
    func setChoosenCategory(category: String){
        
        currentCategory = category
        
    }
    
    func getFrequency(arrayActivity: [Activity]) -> [FrequencyActivity] {
        
        var arrayFrequency = [FrequencyActivity]()
        
        for activity in arrayActivity {
            var frequencyDict = savedInformation.objectForKey("FREQUENCY_\(activity.id)") as! NSMutableDictionary
            
            var amountWeeks = frequencyDict.objectForKey("amountWeeks") as! Int
            var daysWithAmountForDay = frequencyDict.objectForKey("daysWithAmountForDay")  as! NSMutableDictionary
            var id = frequencyDict.objectForKey("id") as! String
            var selectedDaysCount = frequencyDict.objectForKey("selectedDaysCount") as! Int
            var newFrequency = FrequencyActivity(amountWeeks: amountWeeks, daysWithAmountForDay: daysWithAmountForDay, selectedDaysCount: selectedDaysCount)
            
            newFrequency.id = id
            
            arrayFrequency.append(newFrequency)
        }
        
        return arrayFrequency
    }
    
    func getPerformance(arrayActivity: [Activity]) -> [PerformanceForWeek]
    {
        var arrayPerformance = [PerformanceForWeek]()
        
        for activity in arrayActivity
        {
            var performanceDict = savedInformation.objectForKey("PERFORMANCE_\(activity.id)") as! NSMutableDictionary
            
            var amountWeeks = performanceDict.objectForKey("numberWeek") as! Int
            var daysWithAmountForDay = performanceDict.objectForKey("daysWithAmountForDay")  as! NSMutableDictionary
            var id = performanceDict.objectForKey("id") as! String
            
            var completed = performanceDict.objectForKey("completed") as! Int
            
            var newPerformance = PerformanceForWeek(numberWeek: amountWeeks, daysWithAmountForDay: daysWithAmountForDay, completed: completed)
            newPerformance.id = id
            
            arrayPerformance.append(newPerformance)
        }
        
        return arrayPerformance
    }
    
    func saveActivity(newActivity: Activity, newFrequency: FrequencyActivity)->Bool{
        
        
        var numActivity = savedInformation.integerForKey("ActivityAmount")
   
        
        let newDict: NSMutableDictionary = ["name": "\(newActivity.name)","category":"\(newActivity.category)", "id":"\(numActivity)","lastVideo":"\(newActivity.lastVideo)","note": "\(newActivity.note)","videoTutorial":"\(newActivity.videoTutorial)"]
        savedInformation.setObject(newDict, forKey: "ACTIVITY_\(numActivity)")
        
        let newFreqDict: NSMutableDictionary = ["amountWeeks": newFrequency.amountWeeks,"daysWithAmountForDay": newFrequency.daysWithAmountForDay as NSMutableDictionary , "id":"\(numActivity)", "selectedDaysCount": newFrequency.selectedDaysCount]
        
        savedInformation.setObject(newFreqDict, forKey: "FREQUENCY_\(numActivity)")
        
        var daysWithAmountForDay: NSMutableDictionary = [ "1" : 0, "2" : 0, "3" : 0, "4" : 0, "5" : 0, "6" : 0, "7" : 0]
        let dictPerformance: NSMutableDictionary = ["numberWeek": 0, "daysWithAmountForDay": daysWithAmountForDay , "id":"\(numActivity)", "completed": 0]
        savedInformation.setObject(dictPerformance, forKey: "PERFORMANCE_\(numActivity)")

        numActivity+=1
        savedInformation.setInteger(numActivity, forKey: "ActivityAmount")
        savedInformation.synchronize()

        return true
    }
    
    func updatePerformance(performance: PerformanceForWeek,weekDay: Int) -> PerformanceForWeek{
        
        var dictPerformance: NSMutableDictionary = savedInformation.objectForKey("PERFORMANCE_\(performance.id)")?.mutableCopy() as! NSMutableDictionary
        var dictDays: NSMutableDictionary = dictPerformance.objectForKey("daysWithAmountForDay")?.mutableCopy() as! NSMutableDictionary
        var dayRepetition = dictDays.objectForKey("\(weekDay)") as! Int
        
        dayRepetition += 1
        
        dictDays.setValue(dayRepetition as Int, forKey: "\(weekDay)")
        dictPerformance.setObject(dictDays, forKey: "daysWithAmountForDay")
        
        savedInformation.setObject(dictPerformance, forKey: "PERFORMANCE_\(performance.id)")
        
        var performanceDict = savedInformation.objectForKey("PERFORMANCE_\(performance.id)") as! NSMutableDictionary
        var amountWeeks = performanceDict.objectForKey("numberWeek") as! Int
        var daysWithAmountForDay = performanceDict.objectForKey("daysWithAmountForDay")  as! NSMutableDictionary
        var id = performanceDict.objectForKey("id") as! String
        var completed = performanceDict.objectForKey("completed") as! Int
        var newPerformance = PerformanceForWeek(numberWeek: amountWeeks, daysWithAmountForDay: daysWithAmountForDay, completed: completed)
        newPerformance.id = performance.id
        
        return newPerformance
    }
    
    func updatePerformanceCompleted(performance: PerformanceForWeek) -> PerformanceForWeek{
        
        var dictPerformance: NSMutableDictionary = savedInformation.objectForKey("PERFORMANCE_\(performance.id)")?.mutableCopy() as! NSMutableDictionary
        var completed = dictPerformance.objectForKey("completed") as! Int
        
        completed += 1
        
        dictPerformance.setValue(completed, forKey: "completed")
        savedInformation.setObject(dictPerformance, forKey: "PERFORMANCE_\(performance.id)")
        
        
        var performanceDict = savedInformation.objectForKey("PERFORMANCE_\(performance.id)") as! NSMutableDictionary
        var amountWeeks = performanceDict.objectForKey("numberWeek") as! Int
        var daysWithAmountForDay = performanceDict.objectForKey("daysWithAmountForDay")  as! NSMutableDictionary
        var id = performanceDict.objectForKey("id") as! String
        var newCompleted = performanceDict.objectForKey("completed") as! Int
        var newPerformance = PerformanceForWeek(numberWeek: amountWeeks, daysWithAmountForDay: daysWithAmountForDay, completed: newCompleted)
        newPerformance.id = performance.id
        
        return performance
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
    
    func checkNotification() -> Bool {
        var checkNotification = 0
        
        var numActivity = savedInformation.integerForKey("ActivityAmount")
        
        for ( var i = 0; i < numActivity; i++){
            var frequencyDict = savedInformation.objectForKey("FREQUENCY_\(i)") as! NSMutableDictionary
            var daysWithAmountForDay = frequencyDict.objectForKey("daysWithAmountForDay")  as! NSMutableDictionary
            
            for (var temp = 1; temp < 8; temp++ ){
                var dayRepetition = daysWithAmountForDay.objectForKey("\(temp)") as! Int
                if (dayRepetition > 0){
                    checkNotification = 1
                    return true
                }
            }
        }
        
        return false
    }
    
    func notification() {
        
        var gregorian = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
        var calendar: NSCalendar = NSCalendar.currentCalendar()
        var compYear = calendar.components(NSCalendarUnit.YearCalendarUnit, fromDate: NSDate())
        var compDay = calendar.components(NSCalendarUnit.DayCalendarUnit, fromDate: NSDate())
        var compMonth = calendar.components(NSCalendarUnit.MonthCalendarUnit, fromDate: NSDate())

        var dateComp: NSDateComponents = NSDateComponents()
        dateComp.year = compYear.year
        dateComp.month = compMonth.month
        dateComp.day = compDay.day
        dateComp.hour = 17
        dateComp.minute = 38
        dateComp.timeZone = NSTimeZone.systemTimeZone()
        
        
        var date: NSDate = calendar.dateFromComponents(dateComp)!
        
        var notification: UILocalNotification = UILocalNotification()
        notification.category = "FIRST_CATEGORY"
        notification.alertBody = "Você já praticou hoje?"
        notification.fireDate = date
        
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
    }
    
    func delayNotification(hour: Int, minute: Int) {
        var gregorian = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
        var calendar: NSCalendar = NSCalendar.currentCalendar()
        var compYear = calendar.components(NSCalendarUnit.YearCalendarUnit, fromDate: NSDate())
        var compDay = calendar.components(NSCalendarUnit.DayCalendarUnit, fromDate: NSDate())
        var compMonth = calendar.components(NSCalendarUnit.MonthCalendarUnit, fromDate: NSDate())
        var compHour = calendar.components(NSCalendarUnit.HourCalendarUnit, fromDate: NSDate())
        var compMinute = calendar.components(NSCalendarUnit.MinuteCalendarUnit, fromDate: NSDate())
        
        var newMinute = 0
        var newHour = 0
        
        
        if( (minute + compMinute.minute) > 60){
            newMinute = (minute + compMinute.minute) - 60
            newHour = hour + 1
            
        }else if ((minute + compMinute.minute) == 60 ){
            newMinute = 00
            newHour = compHour.hour + 1
        }else{
            newMinute = (minute + compMinute.minute)
            newHour = (hour + compHour.hour)
        }
            
        var dateComp: NSDateComponents = NSDateComponents()
        dateComp.year = compYear.year
        dateComp.month = compMonth.month
        dateComp.day = compDay.day
        dateComp.hour = newHour
        dateComp.minute = newMinute
        dateComp.timeZone = NSTimeZone.systemTimeZone()
        
        var date: NSDate = calendar.dateFromComponents(dateComp)!
        
        var notification: UILocalNotification = UILocalNotification()
        notification.category = "FIRST_CATEGORY"
        notification.alertBody = "Você já praticou hoje?"
        notification.fireDate = date
        
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
    }
    
    func uptadeActivityNotas(newNote: String, activity: Activity){
        
        var dictActivity: NSMutableDictionary = savedInformation.objectForKey("ACTIVITY_\(activity.id)")?.mutableCopy() as! NSMutableDictionary
        var note = dictActivity.objectForKey("note") as! String
        note = newNote
        dictActivity.setValue(note , forKey: "note")
        savedInformation.setObject(dictActivity, forKey: "ACTIVITY_\(activity.id)")
        
    }

}
