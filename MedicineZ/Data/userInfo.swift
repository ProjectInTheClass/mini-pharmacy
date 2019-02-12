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
    var alarmTimeSetting2:String?
    var alarmTimeSetting3:String?
    var segment:String
    var repetition:String?
    var eatingDay:String?
    var notEatingDay:String?
    
    
    init(alarmName: String, memo: String, alarmTimeSetting: String, alarmTimeSetting2: String, alarmTimeSetting3: String, segment: String, repetition:String, eatingDay: String, notEatingDay: String) {
        self.alarmName = alarmName
        self.memo = memo
        self.alarmTimeSetting = alarmTimeSetting
        self.alarmTimeSetting2 = alarmTimeSetting2
        self.alarmTimeSetting3 = alarmTimeSetting3
        self.segment = segment
        self.repetition = repetition
        self.eatingDay = eatingDay
        self.notEatingDay = notEatingDay
      
    }
    required init?(coder aDecoder: NSCoder) {
        self.alarmName = aDecoder.decodeObject(forKey: "name") as! String
        self.memo = aDecoder.decodeObject(forKey: "memo") as! String
        self.alarmTimeSetting = aDecoder.decodeObject(forKey: "time") as? String
        self.alarmTimeSetting2 = aDecoder.decodeObject(forKey: "time2") as? String
        self.alarmTimeSetting3 = aDecoder.decodeObject(forKey: "time3") as? String
        self.segment = aDecoder.decodeObject(forKey: "segment") as! String
        self.repetition = aDecoder.decodeObject(forKey: "repeat") as? String
        self.eatingDay = aDecoder.decodeObject(forKey: "eating") as? String
        self.notEatingDay = aDecoder.decodeObject(forKey: "notEating") as? String
 

    }
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.alarmName, forKey: "name")
        aCoder.encode(self.memo, forKey: "memo")
        aCoder.encode(self.alarmTimeSetting, forKey: "time")
        aCoder.encode(self.alarmTimeSetting2, forKey: "time2")
        aCoder.encode(self.alarmTimeSetting3, forKey: "time3")
        aCoder.encode(self.segment, forKey: "segment")
        aCoder.encode(self.repetition, forKey: "repeat")
        aCoder.encode(self.eatingDay, forKey: "eating")
        aCoder.encode(self.notEatingDay, forKey: "notEating")
    }
}
