//
//  AlarmInfoTableViewController.swift
//  MedicineZ
//
//  Created by CAU on 10/02/2019.
//  Copyright © 2019 CAU. All rights reserved.
//

import UIKit

class AlarmInfoTableViewController: UITableViewController {
    
    var alarmInfoPillList = [[String:String]]()
    
    var alarmInfoIndexPath = IndexPath()

    @IBOutlet weak var alarmName: UILabel!
    @IBOutlet weak var alarmTime: UILabel!
    @IBOutlet weak var when: UILabel!
    @IBOutlet weak var repetition: UILabel!
    @IBOutlet weak var memo: UILabel!
    @IBOutlet weak var eatingDay: UILabel!
    @IBOutlet weak var notEatingDay: UILabel!
    
    @IBOutlet weak var pillList1: UILabel!
    @IBOutlet weak var pillList2: UILabel!
    @IBOutlet weak var pillList3: UILabel!
    @IBOutlet weak var pillList4: UILabel!
    @IBOutlet weak var pillList5: UILabel!
    @IBOutlet weak var pillList6: UILabel!
    @IBOutlet weak var pillList7: UILabel!
    @IBOutlet weak var pillList8: UILabel!
    @IBOutlet weak var pillList9: UILabel!
    @IBOutlet weak var pillList10: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        pillList1.text = ""
        pillList2.text = ""
        pillList3.text = ""
        pillList4.text = ""
        pillList5.text = ""
        pillList6.text = ""
        pillList7.text = ""
        pillList8.text = ""
        pillList9.text = ""
        pillList10.text = ""
        
//        alarmName.text = alarmInfoName
//        alarmTime.text = alarmInfoTime
//        when.text = alarmInfoWhen
//        repetition.text = alarmInfoRepetition
//        memo.text = alarmInfoMemo
//        eatingDay!.text = "복약일 : " + alarmInfoEatingDay
//        notEatingDay!.text = "휴약일 : " + alarmInfoNotEatingDay
//        print(alarmInfoPillList)
        alarmName.text = DataCenter.sharedInstnce.drugList[alarmInfoIndexPath.row].alarmName
        alarmTime.text = DataCenter.sharedInstnce.drugList[alarmInfoIndexPath.row].alarmTimeSetting
        when.text = DataCenter.sharedInstnce.drugList[alarmInfoIndexPath.row].segment
        repetition.text = DataCenter.sharedInstnce.drugList[alarmInfoIndexPath.row].repetition
        memo.text = DataCenter.sharedInstnce.drugList[alarmInfoIndexPath.row].memo
        eatingDay!.text = "복약일 : " + DataCenter.sharedInstnce.drugList[alarmInfoIndexPath.row].eatingDay!
        notEatingDay!.text = "휴약일 : " + DataCenter.sharedInstnce.drugList[alarmInfoIndexPath.row].notEatingDay!
        alarmInfoPillList = DataCenter.sharedInstnce.pillList[alarmInfoIndexPath.row]
        
        
        if alarmInfoPillList.count == 1{
            pillList1.text = "💊 " + alarmInfoPillList[0]["ITEM_NAME"]!
        }else if alarmInfoPillList.count == 2{
            pillList1.text = "💊 " + alarmInfoPillList[0]["ITEM_NAME"]!
            pillList2.text = "💊 " + alarmInfoPillList[1]["ITEM_NAME"]!
        }else if alarmInfoPillList.count == 3{
            pillList1.text = "💊 " + alarmInfoPillList[0]["ITEM_NAME"]!
            pillList2.text = "💊 " + alarmInfoPillList[1]["ITEM_NAME"]!
            pillList3.text = "💊 " + alarmInfoPillList[2]["ITEM_NAME"]!
        }else if alarmInfoPillList.count == 4{
            pillList1.text = "💊 " + alarmInfoPillList[0]["ITEM_NAME"]!
            pillList2.text = "💊 " + alarmInfoPillList[1]["ITEM_NAME"]!
            pillList3.text = "💊 " + alarmInfoPillList[2]["ITEM_NAME"]!
            pillList4.text = "💊 " + alarmInfoPillList[3]["ITEM_NAME"]!
        }else if alarmInfoPillList.count == 5{
            pillList1.text = "💊 " + alarmInfoPillList[0]["ITEM_NAME"]!
            pillList2.text = "💊 " + alarmInfoPillList[1]["ITEM_NAME"]!
            pillList3.text = "💊 " + alarmInfoPillList[2]["ITEM_NAME"]!
            pillList4.text = "💊 " + alarmInfoPillList[3]["ITEM_NAME"]!
            pillList5.text = "💊 " + alarmInfoPillList[4]["ITEM_NAME"]!
        }else if alarmInfoPillList.count == 6{
            pillList1.text = "💊 " + alarmInfoPillList[0]["ITEM_NAME"]!
            pillList2.text = "💊 " + alarmInfoPillList[1]["ITEM_NAME"]!
            pillList3.text = "💊 " + alarmInfoPillList[2]["ITEM_NAME"]!
            pillList4.text = "💊 " + alarmInfoPillList[3]["ITEM_NAME"]!
            pillList5.text = "💊 " + alarmInfoPillList[4]["ITEM_NAME"]!
            pillList6.text = "💊 " + alarmInfoPillList[5]["ITEM_NAME"]!
        }else if alarmInfoPillList.count == 7{
            pillList1.text = "💊 " + alarmInfoPillList[0]["ITEM_NAME"]!
            pillList2.text = "💊 " + alarmInfoPillList[1]["ITEM_NAME"]!
            pillList3.text = "💊 " + alarmInfoPillList[2]["ITEM_NAME"]!
            pillList4.text = "💊 " + alarmInfoPillList[3]["ITEM_NAME"]!
            pillList5.text = "💊 " + alarmInfoPillList[4]["ITEM_NAME"]!
            pillList6.text = "💊 " + alarmInfoPillList[5]["ITEM_NAME"]!
            pillList7.text = "💊 " + alarmInfoPillList[6]["ITEM_NAME"]!
        }else if alarmInfoPillList.count == 8{
            pillList1.text = "💊 " + alarmInfoPillList[0]["ITEM_NAME"]!
            pillList2.text = "💊 " + alarmInfoPillList[1]["ITEM_NAME"]!
            pillList3.text = "💊 " + alarmInfoPillList[2]["ITEM_NAME"]!
            pillList4.text = "💊 " + alarmInfoPillList[3]["ITEM_NAME"]!
            pillList5.text = "💊 " + alarmInfoPillList[4]["ITEM_NAME"]!
            pillList6.text = "💊 " + alarmInfoPillList[5]["ITEM_NAME"]!
            pillList7.text = "💊 " + alarmInfoPillList[6]["ITEM_NAME"]!
            pillList8.text = "💊 " + alarmInfoPillList[7]["ITEM_NAME"]!
        }else if alarmInfoPillList.count == 9{
            pillList1.text = "💊 " + alarmInfoPillList[0]["ITEM_NAME"]!
            pillList2.text = "💊 " + alarmInfoPillList[1]["ITEM_NAME"]!
            pillList3.text = "💊 " + alarmInfoPillList[2]["ITEM_NAME"]!
            pillList4.text = "💊 " + alarmInfoPillList[3]["ITEM_NAME"]!
            pillList5.text = "💊 " + alarmInfoPillList[4]["ITEM_NAME"]!
            pillList6.text = "💊 " + alarmInfoPillList[5]["ITEM_NAME"]!
            pillList7.text = "💊 " + alarmInfoPillList[6]["ITEM_NAME"]!
            pillList8.text = "💊 " + alarmInfoPillList[7]["ITEM_NAME"]!
            pillList9.text = "💊 " + alarmInfoPillList[8]["ITEM_NAME"]!
        }else if alarmInfoPillList.count == 10{
            pillList1.text = "💊 " + alarmInfoPillList[0]["ITEM_NAME"]!
            pillList2.text = "💊 " + alarmInfoPillList[1]["ITEM_NAME"]!
            pillList3.text = "💊 " + alarmInfoPillList[2]["ITEM_NAME"]!
            pillList4.text = "💊 " + alarmInfoPillList[3]["ITEM_NAME"]!
            pillList5.text = "💊 " + alarmInfoPillList[4]["ITEM_NAME"]!
            pillList6.text = "💊 " + alarmInfoPillList[5]["ITEM_NAME"]!
            pillList7.text = "💊 " + alarmInfoPillList[6]["ITEM_NAME"]!
            pillList8.text = "💊 " + alarmInfoPillList[7]["ITEM_NAME"]!
            pillList9.text = "💊 " + alarmInfoPillList[8]["ITEM_NAME"]!
            pillList10.text = "💊 " + alarmInfoPillList[9]["ITEM_NAME"]!
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        pillList1.text = ""
        pillList2.text = ""
        pillList3.text = ""
        pillList4.text = ""
        pillList5.text = ""
        pillList6.text = ""
        pillList7.text = ""
        pillList8.text = ""
        pillList9.text = ""
        pillList10.text = ""
        
        //        alarmName.text = alarmInfoName
        //        alarmTime.text = alarmInfoTime
        //        when.text = alarmInfoWhen
        //        repetition.text = alarmInfoRepetition
        //        memo.text = alarmInfoMemo
        //        eatingDay!.text = "복약일 : " + alarmInfoEatingDay
        //        notEatingDay!.text = "휴약일 : " + alarmInfoNotEatingDay
        //        print(alarmInfoPillList)
        alarmName.text = DataCenter.sharedInstnce.drugList[alarmInfoIndexPath.row].alarmName
        alarmTime.text = DataCenter.sharedInstnce.drugList[alarmInfoIndexPath.row].alarmTimeSetting
        when.text = DataCenter.sharedInstnce.drugList[alarmInfoIndexPath.row].segment
        repetition.text = DataCenter.sharedInstnce.drugList[alarmInfoIndexPath.row].repetition
        memo.text = DataCenter.sharedInstnce.drugList[alarmInfoIndexPath.row].memo
        eatingDay!.text = "복약일 : " + DataCenter.sharedInstnce.drugList[alarmInfoIndexPath.row].eatingDay!
        notEatingDay!.text = "휴약일 : " + DataCenter.sharedInstnce.drugList[alarmInfoIndexPath.row].notEatingDay!
        alarmInfoPillList = DataCenter.sharedInstnce.pillList[alarmInfoIndexPath.row]
        
        
        if alarmInfoPillList.count == 1{
            pillList1.text = "💊 " + alarmInfoPillList[0]["ITEM_NAME"]!
        }else if alarmInfoPillList.count == 2{
            pillList1.text = "💊 " + alarmInfoPillList[0]["ITEM_NAME"]!
            pillList2.text = "💊 " + alarmInfoPillList[1]["ITEM_NAME"]!
        }else if alarmInfoPillList.count == 3{
            pillList1.text = "💊 " + alarmInfoPillList[0]["ITEM_NAME"]!
            pillList2.text = "💊 " + alarmInfoPillList[1]["ITEM_NAME"]!
            pillList3.text = "💊 " + alarmInfoPillList[2]["ITEM_NAME"]!
        }else if alarmInfoPillList.count == 4{
            pillList1.text = "💊 " + alarmInfoPillList[0]["ITEM_NAME"]!
            pillList2.text = "💊 " + alarmInfoPillList[1]["ITEM_NAME"]!
            pillList3.text = "💊 " + alarmInfoPillList[2]["ITEM_NAME"]!
            pillList4.text = "💊 " + alarmInfoPillList[3]["ITEM_NAME"]!
        }else if alarmInfoPillList.count == 5{
            pillList1.text = "💊 " + alarmInfoPillList[0]["ITEM_NAME"]!
            pillList2.text = "💊 " + alarmInfoPillList[1]["ITEM_NAME"]!
            pillList3.text = "💊 " + alarmInfoPillList[2]["ITEM_NAME"]!
            pillList4.text = "💊 " + alarmInfoPillList[3]["ITEM_NAME"]!
            pillList5.text = "💊 " + alarmInfoPillList[4]["ITEM_NAME"]!
        }else if alarmInfoPillList.count == 6{
            pillList1.text = "💊 " + alarmInfoPillList[0]["ITEM_NAME"]!
            pillList2.text = "💊 " + alarmInfoPillList[1]["ITEM_NAME"]!
            pillList3.text = "💊 " + alarmInfoPillList[2]["ITEM_NAME"]!
            pillList4.text = "💊 " + alarmInfoPillList[3]["ITEM_NAME"]!
            pillList5.text = "💊 " + alarmInfoPillList[4]["ITEM_NAME"]!
            pillList6.text = "💊 " + alarmInfoPillList[5]["ITEM_NAME"]!
        }else if alarmInfoPillList.count == 7{
            pillList1.text = "💊 " + alarmInfoPillList[0]["ITEM_NAME"]!
            pillList2.text = "💊 " + alarmInfoPillList[1]["ITEM_NAME"]!
            pillList3.text = "💊 " + alarmInfoPillList[2]["ITEM_NAME"]!
            pillList4.text = "💊 " + alarmInfoPillList[3]["ITEM_NAME"]!
            pillList5.text = "💊 " + alarmInfoPillList[4]["ITEM_NAME"]!
            pillList6.text = "💊 " + alarmInfoPillList[5]["ITEM_NAME"]!
            pillList7.text = "💊 " + alarmInfoPillList[6]["ITEM_NAME"]!
        }else if alarmInfoPillList.count == 8{
            pillList1.text = "💊 " + alarmInfoPillList[0]["ITEM_NAME"]!
            pillList2.text = "💊 " + alarmInfoPillList[1]["ITEM_NAME"]!
            pillList3.text = "💊 " + alarmInfoPillList[2]["ITEM_NAME"]!
            pillList4.text = "💊 " + alarmInfoPillList[3]["ITEM_NAME"]!
            pillList5.text = "💊 " + alarmInfoPillList[4]["ITEM_NAME"]!
            pillList6.text = "💊 " + alarmInfoPillList[5]["ITEM_NAME"]!
            pillList7.text = "💊 " + alarmInfoPillList[6]["ITEM_NAME"]!
            pillList8.text = "💊 " + alarmInfoPillList[7]["ITEM_NAME"]!
        }else if alarmInfoPillList.count == 9{
            pillList1.text = "💊 " + alarmInfoPillList[0]["ITEM_NAME"]!
            pillList2.text = "💊 " + alarmInfoPillList[1]["ITEM_NAME"]!
            pillList3.text = "💊 " + alarmInfoPillList[2]["ITEM_NAME"]!
            pillList4.text = "💊 " + alarmInfoPillList[3]["ITEM_NAME"]!
            pillList5.text = "💊 " + alarmInfoPillList[4]["ITEM_NAME"]!
            pillList6.text = "💊 " + alarmInfoPillList[5]["ITEM_NAME"]!
            pillList7.text = "💊 " + alarmInfoPillList[6]["ITEM_NAME"]!
            pillList8.text = "💊 " + alarmInfoPillList[7]["ITEM_NAME"]!
            pillList9.text = "💊 " + alarmInfoPillList[8]["ITEM_NAME"]!
        }else if alarmInfoPillList.count == 10{
            pillList1.text = "💊 " + alarmInfoPillList[0]["ITEM_NAME"]!
            pillList2.text = "💊 " + alarmInfoPillList[1]["ITEM_NAME"]!
            pillList3.text = "💊 " + alarmInfoPillList[2]["ITEM_NAME"]!
            pillList4.text = "💊 " + alarmInfoPillList[3]["ITEM_NAME"]!
            pillList5.text = "💊 " + alarmInfoPillList[4]["ITEM_NAME"]!
            pillList6.text = "💊 " + alarmInfoPillList[5]["ITEM_NAME"]!
            pillList7.text = "💊 " + alarmInfoPillList[6]["ITEM_NAME"]!
            pillList8.text = "💊 " + alarmInfoPillList[7]["ITEM_NAME"]!
            pillList9.text = "💊 " + alarmInfoPillList[8]["ITEM_NAME"]!
            pillList10.text = "💊 " + alarmInfoPillList[9]["ITEM_NAME"]!
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let detailVC = segue.destination as? EditAlarmInfoTableViewController{
           
            detailVC.infoIndexPath = alarmInfoIndexPath
            
        }
    }

        
}



