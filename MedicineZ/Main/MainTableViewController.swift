//
//  MainTableViewController.swift
//  MedicineZ
//
//  Created by CAU on 01/02/2019.
//  Copyright © 2019 CAU. All rights reserved.
//
import UserNotifications
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
    var alarmGranted:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLocalNotification()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()//데이터 계속 리로드해주는 거
       
    }
    func setLocalNotification() {
        
        if #available(iOS 10.0, *) {
            let center = UNUserNotificationCenter.current()
            let options: UNAuthorizationOptions = [.alert, .sound];
            
            center.requestAuthorization(options: options) {
                (granted, error) in
                if granted {
                    self.alarmGranted = true
                    UserDefaults.standard.set(self.alarmGranted, forKey: "switchState")
                }
            }
        }
        UserDefaults.standard.synchronize()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return DataCenter.sharedInstance.drugList.count
        }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! TableViewCell
        cell.alarmName?.text = DataCenter.sharedInstance.drugList[indexPath.row].alarmName
        cell.alarmTimeSetting?.text = DataCenter.sharedInstance.drugList[indexPath.row].alarmTimeSetting! + "  " + DataCenter.sharedInstance.drugList[indexPath.row].alarmTimeSetting2! + "  " + DataCenter.sharedInstance.drugList[indexPath.row].alarmTimeSetting3!
        if DataCenter.sharedInstance.drugList[indexPath.row].repetition != "매일"{
            cell.repetition?.text = DataCenter.sharedInstance.drugList[indexPath.row].repetition! + "요일마다"
            
        }else{
            cell.repetition?.text = DataCenter.sharedInstance.drugList[indexPath.row].repetition!
        }
        cell.segment?.text = DataCenter.sharedInstance.drugList[indexPath.row].segment
            return cell
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let detailVC = segue.destination as? AlarmInfoTableViewController{
            
            if let drugIdx = self.tableView.indexPathForSelectedRow {
                detailVC.alarmInfoIndexPath = drugIdx
            }
        }
    }
    
    override func tableView(_ tableView:UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return CGFloat(70)
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == UITableViewCell.EditingStyle.delete {
            
            // remove the item from the data model
           
            for i in 0..<DataCenter.sharedInstance.alarmIdentifierList[indexPath.row].count{
                UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["\(DataCenter.sharedInstance.alarmIdentifierList[indexPath.row][i])"])
            } // Notification 삭제
            
            DataCenter.sharedInstance.drugList.remove(at: indexPath.row) //데이터 삭제
            DataCenter.sharedInstance.pillList.remove(at: indexPath.row) //약목록 삭제
            DataCenter.sharedInstance.alarmIdentifierList.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic) // 테이블에서 삭제

        
        }
        
    }
}

extension UITableViewController: UNUserNotificationCenterDelegate {
    
    //for displaying notification when app is in foreground
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        //If you don't want to show notification when app is open, do something here else and make a return here.
        //Even you you don't implement this delegate method, you will not see the notification on the specified controller. So, you have to implement this delegate and make sure the below line execute. i.e. completionHandler.
        
        completionHandler([.alert, .badge, .sound])
    }
    
    // For handling tap and user actions
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        switch response.actionIdentifier {
        case "action1":
            print("Action First Tapped")
        case "action2":
            print("Action Second Tapped")
        default:
            break
        }
        completionHandler()
    }
    
}
