//
//  AddAlarmTableViewController.swift
//  MedicineZ
//
//  Created by CAU on 31/01/2019.
//  Copyright © 2019 CAU. All rights reserved.
//
import UserNotifications
import UIKit



class AddAlarmTableViewController: UITableViewController, AddAlarmViewDelegateProtocol, AddAlarmViewDelegateProtocol2, UITextFieldDelegate {
    var monday: Bool = false
    var tuesday: Bool = false
    var wednesday: Bool = false
    var thursday: Bool = false
    var friday: Bool = false
    var saturday: Bool = false
    var sunday: Bool = false
    var repetition: String = "선택"
    var drugItems = [[String:String]]()
    var buttonIndex:Int = 1

    var alarmIdentifier = [String]()

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
    
    @IBOutlet weak var alarmRepetition: UIButton!
    
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
    @IBOutlet weak var alarmTimeSetting2: UITextField!
    @IBOutlet weak var alarmTimeSetting3: UITextField!
    
    @IBOutlet weak var firstButton: UIButton!
    @IBOutlet weak var secondButton: UIButton!
    @IBAction func firstButton(_ sender: Any) {
        if alarmTimeSetting.text! != "" {
            alarmTimeSetting2.isHidden = false
            firstButton.isHidden = true
            secondButton.isHidden = false
            firstButton.isEnabled = false
            buttonIndex += 1
        } else {
            let alert = UIAlertController(title: "잠깐!", message: "첫 번째 시간을 채워주세요!", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "확인", style: .cancel, handler: nil)
            alert.addAction(cancelAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
    @IBAction func secondButton(_ sender: Any) {
        if alarmTimeSetting2.text! != "" {
            alarmTimeSetting3.isHidden = false
            secondButton.isHidden = true
            buttonIndex += 1
        } else {
            let alert = UIAlertController(title: "잠깐!", message: "두 번째 시간을 채워주세요!", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "확인", style: .cancel, handler: nil)
            alert.addAction(cancelAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    private var datePicker: UIDatePicker?
    private var datePicker2: UIDatePicker?
    private var datePicker3: UIDatePicker?
    
    
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
        if(alarmName.text != "" && alarmTimeSetting.text != "" && alarmRepetition.titleLabel?.text != "선택"){
            alarm()
            DataCenter.sharedInstance.drugList.append(userInfo(alarmName: alarmName.text!, memo: memo.text!, alarmTimeSetting: alarmTimeSetting.text!, alarmTimeSetting2: alarmTimeSetting2.text!, alarmTimeSetting3: alarmTimeSetting3.text!, segment: segment, repetition: repetition))
            DataCenter.sharedInstance.pillList.append(drugItems)
            DataCenter.sharedInstance.alarmIdentifierList.append(alarmIdentifier)
            self.dismiss(animated: true, completion: nil)
        }else{
            let alert = UIAlertController(title: "다시 입력", message: "필수 항목이 다 입력되지 않았어요!", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "확인", style: .cancel, handler: nil)
            alert.addAction(cancelAction)
            self.present(alert, animated: true, completion: nil)
        }
        
        
    }
    
    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        let toolBar = UIToolbar().ToolbarPiker(mySelect: #selector(AddAlarmTableViewController.dismissPicker))
        alarmTimeSetting.inputAccessoryView = toolBar
        alarmTimeSetting2.inputAccessoryView = toolBar
        alarmTimeSetting3.inputAccessoryView = toolBar
        
        //date picker 띄우기
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .time
        datePicker?.addTarget(self, action: #selector(AddAlarmTableViewController.dateChanged(datePicker:)), for: .valueChanged)
        datePicker2 = UIDatePicker()
        datePicker2?.datePickerMode = .time
        datePicker2?.addTarget(self, action: #selector(AddAlarmTableViewController.dateChanged2(datePicker2:)), for: .valueChanged)
        datePicker3 = UIDatePicker()
        datePicker3?.datePickerMode = .time
        datePicker3?.addTarget(self, action: #selector(AddAlarmTableViewController.dateChanged3(datePicker3:)), for: .valueChanged)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(AddAlarmTableViewController.viewTabbed(gestureRecognizer:)))
        view.addGestureRecognizer(tapGesture)
        
        alarmTimeSetting.inputView = datePicker
        alarmTimeSetting2.inputView = datePicker2
        alarmTimeSetting3.inputView = datePicker3
        alarmRepetition.setTitle(repetition, for: .normal)

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
    @objc func dateChanged2(datePicker2: UIDatePicker) {
        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateFormat = "a hh:mm"
        
        alarmTimeSetting2.text = dateFormatter2.string(from: datePicker2.date)
    }
    @objc func dateChanged3(datePicker3: UIDatePicker) {
        let dateFormatter3 = DateFormatter()
        dateFormatter3.dateFormat = "a hh:mm"
        
        alarmTimeSetting3.text = dateFormatter3.string(from: datePicker3.date)
    }
    
    func changeValue(monday: Bool, tuesday: Bool,wednesday: Bool, thursday: Bool, friday: Bool, saturday: Bool, sunday: Bool, repetition: String){
        self.monday = monday
        self.tuesday = tuesday
        self.wednesday = wednesday
        self.thursday = thursday
        self.friday = friday
        self.saturday = saturday
        self.sunday = sunday
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
        alarmRepetition.titleLabel?.adjustsFontSizeToFitWidth = true
        alarmRepetition.setTitle(repetition, for: .normal)
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
    
    
    
    func alarm() {
        if buttonIndex > 0 {
            
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
            
            if subHour == "12" && String(string[string.startIndex]) == "A" {
                dateComponents.hour = dateComponents.hour! - 12
            } else if subHour != "12" && String(string[string.startIndex]) == "P" {
                dateComponents.hour = dateComponents.hour! + 12
            }
            
            if repetition == "매일" {
                var lnMessageId: String = alarmName.text! + "1"
                let content = UNMutableNotificationContent()
                content.title = "미니약국"
                content.body = "약 먹을 시간이에요!"
                content.sound = UNNotificationSound.default
                let lnM = lnMessageId
                let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
                let request = UNNotificationRequest(identifier: lnM, content: content, trigger: trigger)
                let center = UNUserNotificationCenter.current()
                center.add(request) { (error) in
                    print(error?.localizedDescription ?? "")
                }
                alarmIdentifier.append(lnM)
                center.getPendingNotificationRequests(completionHandler: { requests in
                    for request in requests {
                        print(request)
                    }
                })
            }
            if repetition != "매일" && repetition.contains("일") {
                dateComponents.weekday = 1
                var lnMessageId: String = alarmName.text! + "1"
                alarmTrigger(dateMatcing: dateComponents, lnMessageId: lnMessageId)
            }
            if repetition != "매일" && repetition.contains("월") {
                dateComponents.weekday = 2
                var lnMessageId: String = alarmName.text! + "1"
                alarmTrigger(dateMatcing: dateComponents, lnMessageId: lnMessageId)
            }
            if repetition != "매일" && repetition.contains("화") {
                dateComponents.weekday = 3
                var lnMessageId: String = alarmName.text! + "1"
                alarmTrigger(dateMatcing: dateComponents, lnMessageId: lnMessageId)
            }
            if repetition != "매일" && repetition.contains("수") {
                dateComponents.weekday = 4
                var lnMessageId: String = alarmName.text! + "1"
                alarmTrigger(dateMatcing: dateComponents, lnMessageId: lnMessageId)
            }
            if repetition != "매일" && repetition.contains("목") {
                dateComponents.weekday = 5
                var lnMessageId: String = alarmName.text! + "1"
                alarmTrigger(dateMatcing: dateComponents, lnMessageId: lnMessageId)
            }
            if repetition != "매일" && repetition.contains("금") {
                dateComponents.weekday = 6
                var lnMessageId: String = alarmName.text! + "1"
                alarmTrigger(dateMatcing: dateComponents, lnMessageId: lnMessageId)
            }
            if repetition != "매일" && repetition.contains("토") {
                dateComponents.weekday = 7
                var lnMessageId: String = alarmName.text! + "1"
                alarmTrigger(dateMatcing: dateComponents, lnMessageId: lnMessageId)
            }
        }
        if buttonIndex > 1 {
            
            
            if self.alarmTimeSetting2.text! != ""{
            _ = Calendar.current
            var dateComponents2 = DateComponents()
            
            var string2 = self.alarmTimeSetting2.text!
            let startHour = string2.index(string2.startIndex, offsetBy: 3)
            let endHour = string2.index(string2.startIndex, offsetBy: 4)
            let subHour = String(string2[startHour...endHour])
            let startMin = string2.index(string2.startIndex, offsetBy: 6)
            let endMin = string2.index(string2.startIndex, offsetBy: 7)
            let subMin = String(string2[startMin...endMin])
            dateComponents2.hour = Int(subHour)
            dateComponents2.minute = Int(subMin)
            
            if subHour == "12" && String(string2[string2.startIndex]) == "A" {
                dateComponents2.hour = dateComponents2.hour! - 12
            } else if subHour != "12" && String(string2[string2.startIndex]) == "P" {
                dateComponents2.hour = dateComponents2.hour! + 12
            }
            
            if repetition == "매일" {
                var lnMessageId: String = alarmName.text! + "2"
                let content = UNMutableNotificationContent()
                content.title = "미니약국"
                content.body = "약 먹을 시간이에요!"
                content.sound = UNNotificationSound.default
                let lnM = lnMessageId
                let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents2, repeats: true)
                let request = UNNotificationRequest(identifier: lnM, content: content, trigger: trigger)
                let center = UNUserNotificationCenter.current()
                center.add(request) { (error) in
                    print(error?.localizedDescription ?? "")
                }
                alarmIdentifier.append(lnM)
                center.getPendingNotificationRequests(completionHandler: { requests in
                    for request in requests {
                        print(request)
                    }
                })
            }
            if repetition != "매일" && repetition.contains("일") {
                dateComponents2.weekday = 1
                var lnMessageId: String = alarmName.text! + "2"
                alarmTrigger(dateMatcing: dateComponents2, lnMessageId: lnMessageId)
            }
            if repetition != "매일" && repetition.contains("월") {
                dateComponents2.weekday = 2
                var lnMessageId: String = alarmName.text! + "2"
                alarmTrigger(dateMatcing: dateComponents2, lnMessageId: lnMessageId)
            }
            if repetition != "매일" && repetition.contains("화") {
                dateComponents2.weekday = 3
                var lnMessageId: String = alarmName.text! + "2"
                alarmTrigger(dateMatcing: dateComponents2, lnMessageId: lnMessageId)
            }
            if repetition != "매일" && repetition.contains("수") {
                dateComponents2.weekday = 4
                var lnMessageId: String = alarmName.text! + "2"
                alarmTrigger(dateMatcing: dateComponents2, lnMessageId: lnMessageId)
            }
            if repetition != "매일" && repetition.contains("목") {
                dateComponents2.weekday = 5
                var lnMessageId: String = alarmName.text! + "2"
                alarmTrigger(dateMatcing: dateComponents2, lnMessageId: lnMessageId)
            }
            if repetition != "매일" && repetition.contains("금") {
                dateComponents2.weekday = 6
                var lnMessageId: String = alarmName.text! + "2"
                alarmTrigger(dateMatcing: dateComponents2, lnMessageId: lnMessageId)
            }
            if repetition != "매일" && repetition.contains("토") {
                dateComponents2.weekday = 7
                var lnMessageId: String = alarmName.text! + "2"
                alarmTrigger(dateMatcing: dateComponents2, lnMessageId: lnMessageId)
            }
            }
        }
        if buttonIndex > 2 {
            
             if self.alarmTimeSetting3.text! != ""{
            _ = Calendar.current
            var dateComponents3 = DateComponents()
            
            var string3 = self.alarmTimeSetting3.text!
            let startHour = string3.index(string3.startIndex, offsetBy: 3)
            let endHour = string3.index(string3.startIndex, offsetBy: 4)
            let subHour = String(string3[startHour...endHour])
            let startMin = string3.index(string3.startIndex, offsetBy: 6)
            let endMin = string3.index(string3.startIndex, offsetBy: 7)
            let subMin = String(string3[startMin...endMin])
            dateComponents3.hour = Int(subHour)
            dateComponents3.minute = Int(subMin)
            
            if subHour == "12" && String(string3[string3.startIndex]) == "A" {
                dateComponents3.hour = dateComponents3.hour! - 12
            } else if subHour != "12" && String(string3[string3.startIndex]) == "P" {
                dateComponents3.hour = dateComponents3.hour! + 12
            }
            
            if repetition == "매일" {
                var lnMessageId: String = alarmName.text! + "3"
                let content = UNMutableNotificationContent()
                content.title = "미니약국"
                content.body = "약 먹을 시간이에요!"
                content.sound = UNNotificationSound.default
                let lnM = lnMessageId
                let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents3, repeats: true)
                let request = UNNotificationRequest(identifier: lnM, content: content, trigger: trigger)
                let center = UNUserNotificationCenter.current()
                center.add(request) { (error) in
                    print(error?.localizedDescription ?? "")
                }
                alarmIdentifier.append(lnM)
                center.getPendingNotificationRequests(completionHandler: { requests in
                    for request in requests {
                        print(request)
                    }
                })
            }
            if repetition != "매일" && repetition.contains("일") {
                dateComponents3.weekday = 1
                var lnMessageId: String = alarmName.text! + "3"
                alarmTrigger(dateMatcing: dateComponents3, lnMessageId: lnMessageId)
            }
            if repetition != "매일" && repetition.contains("월") {
                dateComponents3.weekday = 2
                var lnMessageId: String = alarmName.text! + "3"
                alarmTrigger(dateMatcing: dateComponents3, lnMessageId: lnMessageId)
            }
            if repetition != "매일" && repetition.contains("화") {
                dateComponents3.weekday = 3
                var lnMessageId: String = alarmName.text! + "3"
                alarmTrigger(dateMatcing: dateComponents3, lnMessageId: lnMessageId)
            }
            if repetition != "매일" && repetition.contains("수") {
                dateComponents3.weekday = 4
                var lnMessageId: String = alarmName.text! + "3"
                alarmTrigger(dateMatcing: dateComponents3, lnMessageId: lnMessageId)
            }
            if repetition != "매일" && repetition.contains("목") {
                dateComponents3.weekday = 5
                var lnMessageId: String = alarmName.text! + "3"
                alarmTrigger(dateMatcing: dateComponents3, lnMessageId: lnMessageId)
            }
            if repetition.count != 14 && repetition.contains("금") {
                dateComponents3.weekday = 6
                var lnMessageId: String = alarmName.text! + "3"
                alarmTrigger(dateMatcing: dateComponents3, lnMessageId: lnMessageId)
            }
            if repetition != "매일" && repetition.contains("토") {
                dateComponents3.weekday = 7
                var lnMessageId: String = alarmName.text! + "3"
                alarmTrigger(dateMatcing: dateComponents3, lnMessageId: lnMessageId)
            }
            
        }
        }
        
    }
    
    func alarmTrigger(dateMatcing: DateComponents, lnMessageId: String) {
        let content = UNMutableNotificationContent()
        content.title = "미니약국"
        content.body = "약 먹을 시간이에요!"
        content.sound = UNNotificationSound.default
        guard let matching = dateMatcing.weekday else {
            let matching = 8
            return
        }
        let lnM = lnMessageId + String(dateMatcing.weekday!)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateMatcing, repeats: true)
        let request = UNNotificationRequest(identifier: lnM, content: content, trigger: trigger)
        let center = UNUserNotificationCenter.current()
        center.add(request) { (error) in
            print(error?.localizedDescription ?? "")
        }
        alarmIdentifier.append(lnM)
       
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
