//
//  eatingDayInfo.swift
//  MedicineZ
//
//  Created by CAU on 08/02/2019.
//  Copyright © 2019 CAU. All rights reserved.
//

import Foundation

class eatingDayInfo:NSObject, NSCoding {
    
    var monday:Bool
    var tuesday:Bool
    var wednesday:Bool
    var thursday:Bool
    var friday:Bool
    var saturday:Bool
    var sunday:Bool
  //  var repetition:String
    
//    , monday:Bool, tuesday:Bool, wednesday:Bool, thursday:Bool, friday:Bool, saturday:Bool, sunday:Bool
    init(monday:Bool, tuesday:Bool, wednesday:Bool, thursday:Bool, friday:Bool, saturday:Bool, sunday:Bool) {
        self.monday = monday
        self.tuesday = tuesday
        self.wednesday = wednesday
        self.thursday = thursday
        self.friday = friday
        self.saturday = saturday
        self.sunday = sunday
      //  self.repetition = repetition
    }
    required init?(coder aDecoder: NSCoder) {

        self.monday = aDecoder.decodeObject(forKey: "mon") as! Bool
        self.tuesday = aDecoder.decodeObject(forKey: "tue") as! Bool
        self.wednesday = aDecoder.decodeObject(forKey: "wed") as! Bool
        self.thursday = aDecoder.decodeObject(forKey: "thu") as! Bool
        self.friday = aDecoder.decodeObject(forKey: "fri") as! Bool
        self.saturday = aDecoder.decodeObject(forKey: "sat") as! Bool
        self.sunday = aDecoder.decodeObject(forKey: "sun") as! Bool
      //  self.repetition = aDecoder.decodeObject(forKey: "repeat") as! String
    }
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.monday, forKey: "mon")
        aCoder.encode(self.tuesday, forKey: "tue")
        aCoder.encode(self.wednesday, forKey: "wed")
        aCoder.encode(self.thursday, forKey: "thu")
        aCoder.encode(self.friday, forKey: "fri")
        aCoder.encode(self.saturday, forKey: "sat")
        aCoder.encode(self.sunday, forKey: "sun")
      //  aCoder.encode(self.repetition, forKey: "repeat")
    }
}
