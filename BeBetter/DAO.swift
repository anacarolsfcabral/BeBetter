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
        var activity = activity
        
        
    
        return false
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
