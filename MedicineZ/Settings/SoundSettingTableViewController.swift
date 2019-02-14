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
    
    var alarmGranted = UserDefaults.standard.bool(forKey: "alarmGranted") // 알림 권한 설정
    var soundNilCheck = UserDefaults.standard.bool(forKey: "soundNilCheck") // 알림 및 알림바 설정
//    var selectedIndexPath = IndexPath(row: 0, section: 0)
//    let alarmDefaultSetting = IndexPath(row: 0, section: 1)
    
    @IBOutlet weak var alarmSwitch: UISwitch!
    @IBAction func alarmSwitch(_ sender: Any) {
        if alarmSwitch.isOn == true {
            print("alarmIsOn")
            setLocalNotification() // 작동 안 함
        } else {
            print("alarmIsOff")
        }
        UserDefaults.standard.set(alarmSwitch.isOn, forKey: "switchState")
        UserDefaults.standard.synchronize()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        alarmSwitch.sendActions(for: .touchUpInside)
        alarmSwitch.isOn = UserDefaults.standard.bool(forKey: "switchState")
//        tableView.cellForRow(at: alarmDefaultSetting)?.accessoryType = UITableViewCell.AccessoryType.checkmark

        
        
        // 체크마크 받아오는 거 수정해야함
        let content = UNMutableNotificationContent()
                
        if soundNilCheck == true {
            content.sound = nil
        } else if soundNilCheck == false {
            content.sound = UNNotificationSound.default
        }

    }
    
    
    func setLocalNotification() {
        
        if #available(iOS 10.0, *) {
            let center = UNUserNotificationCenter.current()
            let options: UNAuthorizationOptions = [.alert, .sound];
            
            center.requestAuthorization(options: options) {
                (granted, error) in
                if granted {
                    self.alarmGranted = true
                    UserDefaults.standard.set(self.alarmGranted, forKey: "alarmGranted")
                } else {
                    self.alarmGranted = false
                    UserDefaults.standard.set(self.alarmGranted, forKey: "alarmGranted")
                }
            }
            
        }
        UserDefaults.standard.synchronize()
    }
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//        if tableView.cellForRow(at: indexPath)?.accessoryType == UITableViewCell.AccessoryType.checkmark
//        {
//            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.none
//            if indexPath.row == 0 {
//
////                UserDefaults.standard.set(soundNilCheck, forKey:"soundNilCheck")
//            }
//
//        } else {
//            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.checkmark
//
//
//        }
//
//
//    }
    
//
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if indexPath == selectedIndexPath{
//            return
//        }
//        if let newCell = tableView.cellForRow(at: indexPath) {
//            if newCell.accessoryType == .none
//            {
//                newCell.accessoryType = .checkmark
//            }
//        }
//        if let oldCell = tableView.cellForRow(at: selectedIndexPath){
//            if oldCell.accessoryType == .checkmark{
//                oldCell.accessoryType = .none
//            }
//        }
//        selectedIndexPath = indexPath
//    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        if indexPath.row == 0 {
            soundNilCheck == false
        } else if indexPath.row == 1 {
            soundNilCheck == true
        }
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
    }
    
    
    
}
