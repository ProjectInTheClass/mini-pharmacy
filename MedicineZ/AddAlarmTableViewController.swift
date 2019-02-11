//
//  AddAlarmTableViewController.swift
//  MedicineZ
//
//  Created by CAU on 31/01/2019.
//  Copyright © 2019 CAU. All rights reserved.
//
import UserNotifications
import UIKit



class AddAlarmTableViewController: UITableViewController, AddAlarmViewDelegateProtocol, AddAlarmViewDelegateProtocol2, UITextFieldDelegate, UNUserNotificationCenterDelegate {
    var eatingDay: String = " "
    var notEatingDay: String = " "
    var monday: Bool = false
    var tuesday: Bool = false
    var wednesday: Bool = false
    var thursday: Bool = false
    var friday: Bool = false
    var saturday: Bool = false
    var sunday: Bool = false
    var repetition: String = ""
    var drugItems = [[String:String]]()

    var alarmGranted: Bool = false

    var drugListName = [String]()
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
    
    @IBAction func cellDelete(_ sender: Any) {
        print(drugItems)
        
        let drugLastIndex = drugItems.count - 1
        if drugLastIndex >= 0{
        drugItems.remove(at: drugLastIndex)
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
    
    @IBOutlet weak var alarmRepetition: UILabel!
    
    var segment:String = "식전"

    @IBOutlet weak var alarmName: UITextField! {didSet { alarmName.delegate = self}}
    @IBOutlet weak var memo: UITextField! {didSet { memo.delegate = self}}
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    @IBOutlet weak var alarmTimeSetting: UITextField!
    
    
    private var datePicker: UIDatePicker?
    
    
    
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
    

    
    
    @IBAction func save(_ sender: Any) {
        if(alarmName.text != "" && alarmTimeSetting.text != "" && alarmRepetition.text != ""){
            DataCenter.sharedInstnce.drugList.append(userInfo(alarmName: alarmName.text!, memo: memo.text!, alarmTimeSetting: alarmTimeSetting.text!, segment: segment, repetition: repetition, eatingDay: eatingDay, notEatingDay: notEatingDay))

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
    
    @IBAction func close(_ sender: Any) {
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
        alarmRepetition.text = repetition
        
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
    
    
    func changeValue(monday: Bool, tuesday: Bool,wednesday: Bool, thursday: Bool, friday: Bool, saturday: Bool, sunday: Bool, eatingDay: String, notEatingDay: String, repetition: String){
        self.monday = monday
        self.tuesday = tuesday
        self.wednesday = wednesday
        self.thursday = thursday
        self.friday = friday
        self.saturday = saturday
        self.sunday = sunday
        self.eatingDay = eatingDay
        self.notEatingDay = notEatingDay
        self.repetition = repetition
        
    }
    
    func addDrugList(drugItem: [String:String]){
        self.drugItems.append(drugItem)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? AlarmRepetitionTableViewController {
            vc.delegate = self
        }
        if let vc = segue.destination as? DrugAddTableViewController{
            vc.delegate = self
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        alarmRepetition.text = repetition
        if drugItems.count == 1{
            drugList1.text = "💊 " + drugItems[0]["ITEM_NAME"]!
        }else if drugItems.count == 2{
            drugList1.text = "💊 " + drugItems[0]["ITEM_NAME"]!
            drugList2.text = "💊 " + drugItems[1]["ITEM_NAME"]!
        }else if drugItems.count == 3{
            drugList1.text = "💊 " + drugItems[0]["ITEM_NAME"]!
            drugList2.text = "💊 " + drugItems[1]["ITEM_NAME"]!
            drugList3.text = "💊 " + drugItems[2]["ITEM_NAME"]!
        }else if drugItems.count == 4{
            drugList1.text = "💊 " + drugItems[0]["ITEM_NAME"]!
            drugList2.text = "💊 " + drugItems[1]["ITEM_NAME"]!
            drugList3.text = "💊 " + drugItems[2]["ITEM_NAME"]!
            drugList4.text = "💊 " + drugItems[3]["ITEM_NAME"]!
        }else if drugItems.count == 5{
            drugList1.text = "💊 " + drugItems[0]["ITEM_NAME"]!
            drugList2.text = "💊 " + drugItems[1]["ITEM_NAME"]!
            drugList3.text = "💊 " + drugItems[2]["ITEM_NAME"]!
            drugList4.text = "💊 " + drugItems[3]["ITEM_NAME"]!
            drugList5.text = "💊 " + drugItems[4]["ITEM_NAME"]!
        }else if drugItems.count == 6{
            drugList1.text = "💊 " + drugItems[0]["ITEM_NAME"]!
            drugList2.text = "💊 " + drugItems[1]["ITEM_NAME"]!
            drugList3.text = "💊 " + drugItems[2]["ITEM_NAME"]!
            drugList4.text = "💊 " + drugItems[3]["ITEM_NAME"]!
            drugList5.text = "💊 " + drugItems[4]["ITEM_NAME"]!
            drugList6.text = "💊 " + drugItems[5]["ITEM_NAME"]!
        }else if drugItems.count == 7{
            drugList1.text = "💊 " + drugItems[0]["ITEM_NAME"]!
            drugList2.text = "💊 " + drugItems[1]["ITEM_NAME"]!
            drugList3.text = "💊 " + drugItems[2]["ITEM_NAME"]!
            drugList4.text = "💊 " + drugItems[3]["ITEM_NAME"]!
            drugList5.text = "💊 " + drugItems[4]["ITEM_NAME"]!
            drugList6.text = "💊 " + drugItems[5]["ITEM_NAME"]!
            drugList7.text = "💊 " + drugItems[6]["ITEM_NAME"]!
        }else if drugItems.count == 8{
            drugList1.text = "💊 " + drugItems[0]["ITEM_NAME"]!
            drugList2.text = "💊 " + drugItems[1]["ITEM_NAME"]!
            drugList3.text = "💊 " + drugItems[2]["ITEM_NAME"]!
            drugList4.text = "💊 " + drugItems[3]["ITEM_NAME"]!
            drugList5.text = "💊 " + drugItems[4]["ITEM_NAME"]!
            drugList6.text = "💊 " + drugItems[5]["ITEM_NAME"]!
            drugList7.text = "💊 " + drugItems[6]["ITEM_NAME"]!
            drugList8.text = "💊 " + drugItems[7]["ITEM_NAME"]!
        }else if drugItems.count == 9{
            drugList1.text = "💊 " + drugItems[0]["ITEM_NAME"]!
            drugList2.text = "💊 " + drugItems[1]["ITEM_NAME"]!
            drugList3.text = "💊 " + drugItems[2]["ITEM_NAME"]!
            drugList4.text = "💊 " + drugItems[3]["ITEM_NAME"]!
            drugList5.text = "💊 " + drugItems[4]["ITEM_NAME"]!
            drugList6.text = "💊 " + drugItems[5]["ITEM_NAME"]!
            drugList7.text = "💊 " + drugItems[6]["ITEM_NAME"]!
            drugList8.text = "💊 " + drugItems[7]["ITEM_NAME"]!
            drugList9.text = "💊 " + drugItems[8]["ITEM_NAME"]!
        }else if drugItems.count == 10{
            drugList1.text = "💊 " + drugItems[0]["ITEM_NAME"]!
            drugList2.text = "💊 " + drugItems[1]["ITEM_NAME"]!
            drugList3.text = "💊 " + drugItems[2]["ITEM_NAME"]!
            drugList4.text = "💊 " + drugItems[3]["ITEM_NAME"]!
            drugList5.text = "💊 " + drugItems[4]["ITEM_NAME"]!
            drugList6.text = "💊 " + drugItems[5]["ITEM_NAME"]!
            drugList7.text = "💊 " + drugItems[6]["ITEM_NAME"]!
            drugList8.text = "💊 " + drugItems[7]["ITEM_NAME"]!
            drugList9.text = "💊 " + drugItems[8]["ITEM_NAME"]!
            drugList10.text = "💊 " + drugItems[9]["ITEM_NAME"]!
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
    

}

extension UIToolbar {
    
    func ToolbarPiker(mySelect : Selector) -> UIToolbar {
        
        let toolBar = UIToolbar()
        
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.black
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "완료", style: UIBarButtonItem.Style.plain, target: self, action: mySelect)
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([ spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        return toolBar
    }
    
}
