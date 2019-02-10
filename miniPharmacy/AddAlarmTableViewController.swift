//
//  AddAlarmTableViewController.swift
//  MedicineZ
//
//  Created by CAU on 31/01/2019.
//  Copyright © 2019 CAU. All rights reserved.
//
import UserNotifications
import UIKit



class AddAlarmTableViewController: UITableViewController, AddAlarmViewDelegateProtocol, UITextFieldDelegate, UNUserNotificationCenterDelegate {
    var eatingDay: String = ""
    var notEatingDay: String = ""
    var monday: Bool = false
    var tuesday: Bool = false
    var wednesday: Bool = false
    var thursday: Bool = false
    var friday: Bool = false
    var saturday: Bool = false
    var sunday: Bool = false
    var repetition: String = ""
    
    var alarmGranted: Bool = false

    
    @IBOutlet weak var alarmRepetition: UILabel!
    
    var segment:String = "식전"

    @IBOutlet weak var alarmName: UITextField! {didSet { alarmName.delegate = self}}
    @IBOutlet weak var memo: UITextField! {didSet { memo.delegate = self}}
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    /*
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
 */
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    //@IBOutlet weak var alarmLabel: UILabel!
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
        //self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLocalNotification()
        //alarmLabel.text = ""
        //alarmTimeSetting.text = "알람 시간 설정"
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
        //view.endEditing(true)
    }
    
    func changeLabel(alarmLabel: String){
        //self.alarmLabel.text = alarmLabel
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? AlarmRepetitionTableViewController {
            vc.delegate = self
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
         alarmRepetition.text = repetition
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
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? TimeViewController {
            vc.delegate = self
        }
    }
 */
 
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
//
//    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
//
//        // Configure the cell...
//
//        return cell
//    }
    

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
