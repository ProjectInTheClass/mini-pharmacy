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
/*
    func longPressCalled(_ longPress: UILongPressGestureRecognizer) {
        print("longPressCalled")
        
        //1. 누른 위치의 indexPath
        let locationInView = longPress.location(in: UITableView)
        let indexPath = UITableView.indexPathForRow(at: locationInView)
        
        
    
    }
    */
    //@IBOutlet weak var alarmLable: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // tableView.estimatedRowHeight = 100
       // tableView.rowHeight = UITableView.automaticDimension
        /*
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(longPressCalled(_:)))
        UITableView.addGestureRecognizer(longPressGesture)
        */
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()//데이터 계속 리로드해주는 거
   //     alarmItem[alarmName] = alarmName

    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows

        return DataCenter.sharedInstnce.drugList.count
       // return DataCenter2.sharedInstnce.eatingDayInfo2.count
        }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! TableViewCell
        //cell.textLabel?.numberOfLines = 0
        cell.alarmName?.text = DataCenter.sharedInstnce.drugList[indexPath.row].alarmName
        cell.alarmTimeSetting?.text = DataCenter.sharedInstnce.drugList[indexPath.row].alarmTimeSetting
        
        cell.repetition?.text = DataCenter.sharedInstnce.drugList[indexPath.row].repetition
    
        
        cell.segment?.text = DataCenter.sharedInstnce.drugList[indexPath.row].segment
        
        //cell.textLabel!.text = DataCenter.sharedInstnce.drugList[indexPath.row].alarmName
        //cell.detailTextLabel!.text = DataCenter.sharedInstnce.drugList[indexPath.row].alarmLabel
            return cell
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let detailVC = segue.destination as? AlarmInfoTableViewController{
            
            if let drugIdx = self.tableView.indexPathForSelectedRow{
                detailVC.alarmInfo = alarmItems[drugIdx.row]
                
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

            // Not used in our example, but if you were adding a new row, this is where you would do it.
        
    }
        
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
}
