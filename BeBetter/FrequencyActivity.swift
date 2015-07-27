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
    var daysWithAmountForDay: NSDictionary
    var id: Int
    
    init (amountWeeks: Int, daysWithAmountForDay: NSDictionary, id: Int){
        self.amountWeeks = amountWeeks
        self.daysWithAmountForDay = daysWithAmountForDay
        self.id = id
        
    }
    
}
