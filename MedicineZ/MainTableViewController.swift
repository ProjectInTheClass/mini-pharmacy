//
//  MainTableViewController.swift
//  MedicineZ
//
//  Created by CAU on 01/02/2019.
//  Copyright © 2019 CAU. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {
    
     var alarmItems = [[String:String]]()
    var alarmItem = [String: String]()
    var repetition = ""
    var alarmName = ""
    var memo = ""
    var alarmTime = ""
    var alarmRepetition = ""
    var when = ""
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()//데이터 계속 리로드해주는 거
       
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return DataCenter.sharedInstnce.drugList.count
        }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! TableViewCell
        cell.alarmName?.text = DataCenter.sharedInstnce.drugList[indexPath.row].alarmName
        cell.alarmTimeSetting?.text = DataCenter.sharedInstnce.drugList[indexPath.row].alarmTimeSetting
        cell.repetition?.text = DataCenter.sharedInstnce.drugList[indexPath.row].repetition
        cell.segment?.text = DataCenter.sharedInstnce.drugList[indexPath.row].segment
            return cell
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let detailVC = segue.destination as? AlarmInfoTableViewController{
            
            if let drugIdx = self.tableView.indexPathForSelectedRow {
                detailVC.alarmInfoName = DataCenter.sharedInstnce.drugList[drugIdx.row].alarmName
                detailVC.alarmInfoTime = DataCenter.sharedInstnce.drugList[drugIdx.row].alarmTimeSetting!
                detailVC.alarmInfoWhen = DataCenter.sharedInstnce.drugList[drugIdx.row].segment
                detailVC.alarmInfoRepetition = DataCenter.sharedInstnce.drugList[drugIdx.row].repetition!
                detailVC.alarmInfoMemo = DataCenter.sharedInstnce.drugList[drugIdx.row].memo
                detailVC.alarmInfoEatingDay = DataCenter.sharedInstnce.drugList[drugIdx.row].eatingDay!
                detailVC.alarmInfoNotEatingDay = DataCenter.sharedInstnce.drugList[drugIdx.row].notEatingDay!
                
            }
        }
    }
    
    override func tableView(_ tableView:UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return CGFloat(70)
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == UITableViewCell.EditingStyle.delete {
            
            // remove the item from the data model
        DataCenter.sharedInstnce.drugList.remove(at: indexPath.row) //데이터 삭제
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic) // 테이블에서 삭제
        
        }
        
    }
}
