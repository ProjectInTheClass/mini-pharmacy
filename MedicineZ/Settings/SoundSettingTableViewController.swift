//
//  SoundSettingTableViewController.swift
//  MedicineZ
//
//  Created by CAU on 12/02/2019.
//  Copyright © 2019 CAU. All rights reserved.
//
import UserNotifications
import UIKit

class SoundSettingTableViewController: UITableViewController, UNUserNotificationCenterDelegate {

    var soundNilCheck: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        let content = UNMutableNotificationContent()
                
        if soundNilCheck == true {
            content.sound = nil
        } else if soundNilCheck == false {
            content.sound = UNNotificationSound.default
        }

    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.cellForRow(at: indexPath)?.accessoryType == UITableViewCell.AccessoryType.checkmark
        {
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.none
            switch indexPath.row{
            case 0:
                soundNilCheck = true
            case 1:
                soundNilCheck = false
            default:
                break
            }
            
        }
//            else {
//            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.checkmark
//            switch indexPath.row{
//            case 0:
//                soundNilCheck = false
//            case 1:
//                soundNilCheck = true
//            default:
//                break
//            }
//
//        }
        
        
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    
}
