//
//  PerformanceForWeek.swift
//  BeBetter
//
//  Created by Mayara Souza on 7/21/15.
//  Copyright (c) 2015 Ana Carolina Cabral. All rights reserved.
//

import Foundation

class PerformanceForWeek {
    
    var numberWeek: Int
    var daysWithAmountForDay: NSDictionary
    var id: Int
    
    init(numberWeek: Int, daysWithAmountForDay: NSDictionary, id: Int){
        self.numberWeek = numberWeek
        self.daysWithAmountForDay = daysWithAmountForDay
        self.id = id
    }
    
}