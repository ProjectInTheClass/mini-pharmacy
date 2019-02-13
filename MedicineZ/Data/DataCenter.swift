//
//  DataCenter.swift
//  MedicineZ
//
//  Created by CAU on 06/02/2019.
//  Copyright © 2019 CAU. All rights reserved.
//

import Foundation

class DataCenter{
    static let sharedInstnce = DataCenter()
    var drugList:[userInfo] = []
    var pillList = [[[String:String]]]()
    var alarmIdentifierList: [[String]] = []
    
    func save() {
        let encodeDate = NSKeyedArchiver.archivedData(withRootObject: drugList)
        UserDefaults.standard.setValue(encodeDate, forKey: "drugList")
        let encodeDate2 = NSKeyedArchiver.archivedData(withRootObject: pillList)
        UserDefaults.standard.setValue(encodeDate2, forKey: "pillList")
        let encodeDate3 = NSKeyedArchiver.archivedData(withRootObject: alarmIdentifierList)
        UserDefaults.standard.setValue(encodeDate3, forKey: "alarmIdentifierList")
    }
    
    func load() {
        guard let encodeDate = UserDefaults.standard.value(forKeyPath: "drugList") as? Data else { return }
        self.drugList = NSKeyedUnarchiver.unarchiveObject(with: encodeDate) as! [userInfo]
        guard let encodeDate2 = UserDefaults.standard.value(forKeyPath: "pillList") as? Data else { return }
        self.pillList = NSKeyedUnarchiver.unarchiveObject(with: encodeDate2) as! [[[String:String]]]
        guard let encodeDate3 = UserDefaults.standard.value(forKeyPath: "alarmIdentifierList") as? Data else { return }
        self.alarmIdentifierList = NSKeyedUnarchiver.unarchiveObject(with: encodeDate3) as! [[String]]
    }
    

}
