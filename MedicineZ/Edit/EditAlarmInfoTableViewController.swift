//
//  EditAlarmInfoTableViewController.swift
//  MedicineZ
//
//  Created by CAU on 11/02/2019.
//  Copyright © 2019 CAU. All rights reserved.
//
import UserNotifications
import UIKit

class EditAlarmInfoTableViewController: UITableViewController, UITextFieldDelegate, UNUserNotificationCenterDelegate, EditAlarmRepetitionProtocol, EditAlarmInfoProtocol {
    var alarmGranted: Bool = false
    var drugItems = [[String:String]]()
    var infoIndexPath = IndexPath()
    var segment = ""
    var repetition: String = ""
    var buttonIndex:Int = 1

    @IBOutlet weak var alarmName: UITextField!
    @IBOutlet weak var memo: UITextField!
    @IBOutlet weak var alarmTimeSetting: UITextField!
    @IBOutlet weak var alarmTimeSetting2: UITextField!
    @IBOutlet weak var alarmTimeSetting3: UITextField!
    
    @IBOutlet weak var alarmRepetition: UIButton!
    
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
            let alert = UIAlertController(title: "이런!", message: "첫 번째 시간을 채워주세요!", preferredStyle: .alert)
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
            let alert = UIAlertController(title: "이런!", message: "두 번째 시간을 채워주세요!", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "확인", style: .cancel, handler: nil)
            alert.addAction(cancelAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    private var datePicker: UIDatePicker?
    private var datePicker2: UIDatePicker?
    private var datePicker3: UIDatePicker?
    
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
        if(alarmName.text != "" && alarmTimeSetting.text != "" && alarmRepetition.titleLabel?.text != ""){
            DataCenter.sharedInstnce.drugList.remove(at: infoIndexPath.row)
            DataCenter.sharedInstnce.drugList.insert(userInfo(alarmName: alarmName.text!, memo: memo.text!, alarmTimeSetting: alarmTimeSetting.text!, alarmTimeSetting2: alarmTimeSetting2.text!, alarmTimeSetting3: alarmTimeSetting3.text!, segment: segment, repetition: repetition), at: infoIndexPath.row)
            DataCenter.sharedInstnce.pillList.remove(at: infoIndexPath.row)
            DataCenter.sharedInstnce.pillList.insert(drugItems, at: infoIndexPath.row)
            
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
            
            self.dismiss(animated: true, completion: nil)
            
        }
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
        
        alarmName.text! = DataCenter.sharedInstnce.drugList[infoIndexPath.row].alarmName
        memo.text! = DataCenter.sharedInstnce.drugList[infoIndexPath.row].memo
        alarmTimeSetting.text! = DataCenter.sharedInstnce.drugList[infoIndexPath.row].alarmTimeSetting!
        alarmTimeSetting2.text! = DataCenter.sharedInstnce.drugList[infoIndexPath.row].alarmTimeSetting2!
        alarmTimeSetting3.text! = DataCenter.sharedInstnce.drugList[infoIndexPath.row].alarmTimeSetting3!
        repetition = DataCenter.sharedInstnce.drugList[infoIndexPath.row].repetition!
        drugItems = DataCenter.sharedInstnce.pillList[infoIndexPath.row]
        segment = DataCenter.sharedInstnce.drugList[infoIndexPath.row].segment
        alarmRepetition.titleLabel?.text! = repetition
        
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
        
        if alarmTimeSetting2.text != ""{
            alarmTimeSetting2.isHidden = false
            firstButton.isHidden = true
            firstButton.isEnabled = false
            secondButton.isHidden = false
            secondButton.isEnabled = true
            alarmTimeSetting3.isHidden = true
            buttonIndex += 1

        }
        if alarmTimeSetting2.text != "" && alarmTimeSetting3.text != ""{
            alarmTimeSetting3.isHidden = false
            secondButton.isHidden = true
            buttonIndex += 1

        }
        alarmRepetition.setTitle(repetition, for: .normal)

    }
    override func viewWillAppear(_ animated: Bool) {
//        alarmRepetition.titleLabel?.adjustsFontSizeToFitWidth = true
        alarmRepetition.titleLabel?.text = repetition
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
    
    func changeValue(repetition: String){
        self.repetition = repetition
        
    }
    func addDrugList(drugItem: [String:String]){
        self.drugItems.append(drugItem)
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
            detailVC.delegate = self
            
        }
        if let detailVC = segue.destination as? EditDrugAddTableViewController{
            detailVC.delegate = self
            
        }
    }
}

