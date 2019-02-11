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
    
    var eatingDayInfo2:[eatingDayInfo] = []
    
    var HomeUpdateCheck = false
    var TimeLineUpdateCheck = false
    var today = ""
    
    func save() {

        let encodeDate = NSKeyedArchiver.archivedData(withRootObject: drugList)
        UserDefaults.standard.setValue(encodeDate, forKey: "drugList")


        
    }
    func save2() {
        let encodeDate2 = NSKeyedArchiver.archivedData(withRootObject: eatingDayInfo2)
        UserDefaults.standard.setValue(encodeDate2, forKey: "eatingDayInfo")    }
    
    func load() {
        guard let encodeDate = UserDefaults.standard.value(forKeyPath: "drugList") as? Data else { return }
        self.drugList = NSKeyedUnarchiver.unarchiveObject(with: encodeDate) as! [userInfo]

        
    }
    
    func load2() {
        guard let encodeDate2 = UserDefaults.standard.value(forKeyPath: "eatingDayInfo") as? Data else { return }
        self.eatingDayInfo2 = NSKeyedUnarchiver.unarchiveObject(with: encodeDate2) as! [eatingDayInfo]
        
    }

}
