//
//  FrequencyActivity.swift
//  BeBetter
//
//  Created by Mayara Souza on 7/21/15.
//  Copyright (c) 2015 Ana Carolina Cabral. All rights reserved.
//

import Foundation

class FrequencyActivity {
    
    var amountWeeks: Int
    var daysWithAmountForDay: NSMutableDictionary
    var id: String
    var selectedDaysCount: Int

    
    init (amountWeeks: Int, daysWithAmountForDay: NSMutableDictionary,selectedDaysCount: Int)
{
        self.amountWeeks = amountWeeks
        self.daysWithAmountForDay = daysWithAmountForDay
        self.id = ""
        self.selectedDaysCount = selectedDaysCount
    }
    
}
