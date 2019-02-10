//
//  Alarm.swift
//  MedicineZ
//
//  Created by CAU on 31/01/2019.
//  Copyright © 2019 CAU. All rights reserved.
//

import Foundation


class userInfo:NSObject, NSCoding {
    
    var alarmName:String
    var memo:String
    var alarmTimeSetting:String?
    var segment:String
    var repetition:String?
    var eatingDay:String?
    var notEatingDay:String?
    
    
    init(alarmName: String, memo: String, alarmTimeSetting: String, segment: String, repetition:String, eatingDay: String, notEatingDay: String) {
        self.alarmName = alarmName
        self.memo = memo
        self.alarmTimeSetting = alarmTimeSetting
        self.segment = segment
        self.repetition = repetition
        self.eatingDay = eatingDay
        self.notEatingDay = notEatingDay
      
    }
    required init?(coder aDecoder: NSCoder) {
        self.alarmName = aDecoder.decodeObject(forKey: "name") as! String
        self.memo = aDecoder.decodeObject(forKey: "memo") as! String
        self.alarmTimeSetting = aDecoder.decodeObject(forKey: "time") as? String
        self.segment = aDecoder.decodeObject(forKey: "segment") as! String
        self.repetition = aDecoder.decodeObject(forKey: "repeat") as? String
        self.eatingDay = aDecoder.decodeObject(forKey: "eating") as? String
        self.notEatingDay = aDecoder.decodeObject(forKey: "notEating") as? String
 

    }
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.alarmName, forKey: "name")
        aCoder.encode(self.memo, forKey: "memo")
        aCoder.encode(self.alarmTimeSetting, forKey: "time")
        aCoder.encode(self.segment, forKey: "segment")
        aCoder.encode(self.repetition, forKey: "repeat")
        aCoder.encode(self.eatingDay, forKey: "eating")
        aCoder.encode(self.notEatingDay, forKey: "notEating")
    }
}
