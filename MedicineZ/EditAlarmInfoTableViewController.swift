//
//  EditAlarmInfoTableViewController.swift
//  MedicineZ
//
//  Created by CAU on 11/02/2019.
//  Copyright © 2019 CAU. All rights reserved.
//
import UserNotifications
import UIKit

class EditAlarmInfoTableViewController: UITableViewController, UITextFieldDelegate, UNUserNotificationCenterDelegate, EditAlarmRepetitionProtocol  {
    
    var alarmGranted: Bool = false
    var pillList = [[String:String]]()
    var infoIndexPath = IndexPath()
    var segment = "식전"
    var repetition: String = ""
    var eatingDay: String = " "
    var notEatingDay: String = " "
    
    @IBOutlet weak var alarmName: UITextField!
    @IBOutlet weak var memo: UITextField!
    @IBOutlet weak var alarmTimeSetting: UITextField!
    @IBOutlet weak var alarmRepetition: UILabel!

    private var datePicker: UIDatePicker?

    @IBAction func cellDelete(_ sender: Any) {
        
        let drugLastIndex = pillList.count - 1
        if drugLastIndex >= 0{
            pillList.remove(at: drugLastIndex)
        }
        drugList1.text = ""
        drugList2.text = ""
        drugList3.text = ""
        drugList4.text = ""
        drugList5.text = ""
        drugList6.text = ""
        drugList7.text = ""
        drugList8.text = ""
        drugList9.text = ""
        drugList10.text = ""
        self.viewWillAppear(true)
    }
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBAction func indexChanged(_ sender: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex
        {
        case 0:
            segment = "식전"
        //show popular view
        case 1:
            segment = "식후"
        //show history view
        case 2:
            segment = "무관"
        default:
            break;
        }
        
    }
    
    
    @IBOutlet weak var drugList1: UILabel!
    @IBOutlet weak var drugList2: UILabel!
    @IBOutlet weak var drugList3: UILabel!
    @IBOutlet weak var drugList4: UILabel!
    @IBOutlet weak var drugList5: UILabel!
    @IBOutlet weak var drugList6: UILabel!
    @IBOutlet weak var drugList7: UILabel!
    @IBOutlet weak var drugList8: UILabel!
    @IBOutlet weak var drugList9: UILabel!
    @IBOutlet weak var drugList10: UILabel!
    
    @IBAction func save(_ sender: Any) {
        if(alarmName.text != "" && alarmTimeSetting.text != "" && alarmRepetition.text != ""){
//            DataCenter.sharedInstnce.drugList.append(userInfo(alarmName: alarmName.text!, memo: memo.text!, alarmTimeSetting: alarmTimeSetting.text!, segment: segment, repetition: repetition, eatingDay: eatingDay, notEatingDay: notEatingDay))
//            DataCenter.sharedInstnce.pillList.append(drugItems)
            self.dismiss(animated: true, completion: nil)
            
        }else{
            let alert = UIAlertController(title: "다시 입력", message: "필수 항목이 다 입력되지 않았어요!", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "확인", style: .cancel, handler: nil)
            alert.addAction(cancelAction)
            self.present(alert, animated: true, completion: nil)
        }
        
        if alarmGranted == true {
            let content = UNMutableNotificationContent()
            content.title = "미니약국"
            content.body = "약 먹을 시간이에요!"
            content.sound = UNNotificationSound.default
            
            _ = Calendar.current
            var dateComponents = DateComponents()
            
            var string = self.alarmTimeSetting.text!
            let startHour = string.index(string.startIndex, offsetBy: 3)
            let endHour = string.index(string.startIndex, offsetBy: 4)
            let subHour = String(string[startHour...endHour])
            let startMin = string.index(string.startIndex, offsetBy: 6)
            let endMin = string.index(string.startIndex, offsetBy: 7)
            let subMin = String(string[startMin...endMin])
            dateComponents.hour = Int(subHour)
            dateComponents.minute = Int(subMin)
            
            if String(string[string.startIndex]) == "P" {
                dateComponents.hour = dateComponents.hour! + 12
            }
            
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
            let request = UNNotificationRequest(identifier: "TRAINING_NOTIFICATION", content: content, trigger: trigger)
            let center = UNUserNotificationCenter.current()
            center.add(request) { (error) in
                print(error?.localizedDescription ?? "")
            }
            
            
            
        }
        self.dismiss(animated: true, completion: nil)
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLocalNotification()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        let toolBar = UIToolbar().ToolbarPiker(mySelect: #selector(AddAlarmTableViewController.dismissPicker))
        alarmTimeSetting.inputAccessoryView = toolBar
        
        
        //date picker 띄우기
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .time
        datePicker?.addTarget(self, action: #selector(AddAlarmTableViewController.dateChanged(datePicker:)), for: .valueChanged)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(AddAlarmTableViewController.viewTabbed(gestureRecognizer:)))
        view.addGestureRecognizer(tapGesture)
        
        alarmTimeSetting.inputView = datePicker
        
        alarmName.text! = DataCenter.sharedInstnce.drugList[infoIndexPath.row].alarmName
        memo.text! = DataCenter.sharedInstnce.drugList[infoIndexPath.row].memo
        alarmTimeSetting.text! = DataCenter.sharedInstnce.drugList[infoIndexPath.row].alarmTimeSetting!
        alarmRepetition.text! = DataCenter.sharedInstnce.drugList[infoIndexPath.row].repetition!
        pillList = DataCenter.sharedInstnce.pillList[infoIndexPath.row]
//
//        if segment == "식전"{
//            segmentedControl.
//        }
    }
    override func viewWillAppear(_ animated: Bool) {
        alarmRepetition.text =  DataCenter.sharedInstnce.drugList[infoIndexPath.row].repetition
    }
    @objc func dismissPicker() {
        view.endEditing(true)
    }
    
    @objc func viewTabbed(gestureRecognizer: UITapGestureRecognizer){
        view.endEditing(true)
    }
    
    @objc func dateChanged(datePicker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "a hh:mm"
        
        alarmTimeSetting.text = dateFormatter.string(from: datePicker.date)
    }
    func changeValue(eatingDay: String, notEatingDay: String, repetition: String){
        self.eatingDay = eatingDay
        self.notEatingDay = notEatingDay
        self.repetition = repetition
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func setLocalNotification() {
        
        if #available(iOS 10.0, *) {
            let center = UNUserNotificationCenter.current()
            let options: UNAuthorizationOptions = [.alert, .sound];
            
            center.requestAuthorization(options: options) {
                (granted, error) in
                if granted {
                    self.alarmGranted = true
                }
            }
            
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["TRAINING_NOTIFICATION"])
        } else {
            if let notifications = UIApplication.shared.scheduledLocalNotifications {
                for notification in notifications {
                    if notification.userInfo?["identifier"] as? String == "TRAINING_NOTIFICATION" {
                        UIApplication.shared.cancelLocalNotification(notification)
                    }
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let detailVC = segue.destination as? EditAlarmRepetitionTableViewController{
            
            if let drugIdx = self.tableView.indexPathForSelectedRow {
                detailVC.alarmIndexPath = drugIdx
            }
        }
    }
}

