//
//  TotalSettingsTableViewController.swift
//  MedicineZ
//
//  Created by CAU on 13/02/2019.
//  Copyright © 2019 CAU. All rights reserved.
//

import UIKit
import UserNotifications
class TotalSettingsTableViewController: UITableViewController {

//    var alarmGranted = UserDefaults.standard.bool(forKey: "alarmGranted")
    @IBOutlet weak var alarmSwitch: UISwitch!
    @IBAction func alarmSwitch(_ sender: Any) {
        UserDefaults.standard.set(alarmSwitch.isOn, forKey: "switchState")
        //        if UserDefaults.standard.bool(forKey: "switchState") == true {
        //
        //        } else {
        //
        //        }
        let alertController = UIAlertController (title: "알림 설정 변경", message: "설정화면으로 이동할까요?", preferredStyle: .alert)
        
        let settingsAction = UIAlertAction(title: "이동", style: .default) { (_) -> Void in
            
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                    print("Settings opened: \(success)") // Prints true
                })
            }
        }
        alertController.addAction(settingsAction)
        let cancelAction = UIAlertAction(title: "취소", style: .default, handler: nil)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let notificationCenter = UNUserNotificationCenter.current()
           notificationCenter.getNotificationSettings { settings in
                
                if settings.alertSetting == .enabled {
                    self.alarmSwitch.isOn = true
                }else{
                    self.alarmSwitch.isOn = false
            }
                
        }
        
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.getNotificationSettings { settings in
            
            if settings.alertSetting == .enabled {
                self.alarmSwitch.isOn = true
            }else{
                self.alarmSwitch.isOn = false
            }
            
        }
        
    }
    
    
    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
