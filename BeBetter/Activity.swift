//
//  Activity.swift
//  BeBetter
//
//  Created by Ana Carolina Cabral on 21/07/15.
//  Copyright (c) 2015 Ana Carolina Cabral. All rights reserved.
//

import Foundation

class Activity {

    var name: String!
    var videoTutorial: String!
    var note: String
    var lastVideo: String
    var id: Int
    var category: String!
    
    init (name: String, videoTutorial: String, category: String){
    
        self.name = name
        self.videoTutorial = videoTutorial
        self.category = category
        self.note = ""
        self.lastVideo = ""
        self.id = 0
    }

}
