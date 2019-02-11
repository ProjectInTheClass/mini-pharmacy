//
//  AlarmInfoTableViewController.swift
//  MedicineZ
//
//  Created by CAU on 10/02/2019.
//  Copyright © 2019 CAU. All rights reserved.
//

import UIKit

class AlarmInfoTableViewController: UITableViewController {
    var alarmInfoName:String = ""
    var alarmInfoTime:String = ""
    var alarmInfoWhen:String = ""
    var alarmInfoRepetition:String = ""
    var alarmInfoMemo:String = ""
    var alarmInfoEatingDay:String = ""
    var alarmInfoNotEatingDay:String = ""

    @IBOutlet weak var alarmName: UILabel!
    @IBOutlet weak var alarmTime: UILabel!
    @IBOutlet weak var when: UILabel!
    @IBOutlet weak var repetition: UILabel!
    @IBOutlet weak var memo: UILabel!
    @IBOutlet weak var eatingDay: UILabel!
    @IBOutlet weak var notEatingDay: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        alarmName.text = alarmInfoName
        alarmTime.text = alarmInfoTime
        when.text = alarmInfoWhen
        repetition.text = alarmInfoRepetition
        memo.text = alarmInfoMemo
        eatingDay!.text = "복약일 : " + alarmInfoEatingDay
        notEatingDay!.text = "휴약일 : " + alarmInfoNotEatingDay
    }


        
}



