//
//  AlarmReperirionTableViewController.swift
//  MedicineZ
//
//  Created by CAU on 08/02/2019.
//  Copyright © 2019 CAU. All rights reserved.
//

import UIKit
protocol AddAlarmViewDelegateProtocol {
    func changeValue(monday: Bool, tuesday: Bool,wednesday: Bool, thursday: Bool, friday: Bool, saturday: Bool, sunday: Bool, eatingDay: String, notEatingDay: String, repetition: String)
    
}

class AlarmRepetitionTableViewController: UITableViewController,UITextFieldDelegate{
    
    var delegate:AddAlarmViewDelegateProtocol?

   // let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: IndexPath)
   
    var monday:Bool = false
    var tuesday:Bool = false
    var wednesday:Bool = false
    var thursday:Bool = false
    var friday:Bool = false
    var saturday:Bool = false
    var sunday:Bool = false
    var repetition:String = ""
 
    
    @IBOutlet weak var eatingDay: UITextField! {didSet { eatingDay.delegate = self}}
    @IBOutlet weak var notEatingDay: UITextField! {didSet { notEatingDay.delegate = self}}
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.allowsMultipleSelection = true

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source
/*
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
*/
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.cellForRow(at: indexPath)?.accessoryType == UITableViewCell.AccessoryType.checkmark
        {
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.none
            switch indexPath.row{
            case 0:
                monday = false
            case 1:
                tuesday = false
            case 2:
                wednesday = false
            case 3:
                thursday = false
            case 4:
                friday = false
            case 5:
                saturday = false
            case 6:
                sunday = false
            default:
                break
            }
            print("\(indexPath.row)")
            print(monday)
            print(tuesday)
            print(wednesday)
            print(thursday)
            print(friday)
            print(saturday)
            print(sunday)
            
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.checkmark
            switch indexPath.row{
            case 0:
                monday = true
            case 1:
                tuesday = true
            case 2:
                wednesday = true
            case 3:
                thursday = true
            case 4:
                friday = true
            case 5:
                saturday = true
            case 6:
                sunday = true
            default:
                break
            }
            print("\(indexPath.row)")
            print(monday)
            print(tuesday)
            print(wednesday)
            print(thursday)
            print(friday)
            print(saturday)
            print(sunday)

        }

        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if self.navigationController?.topViewController != self {
            if monday {
                repetition = "월 "
            }
            if tuesday {
                repetition += "화 "
            }
            if wednesday {
                repetition += "수 "
            }
            if thursday {
                repetition += "목 "
            }
            if friday {
                repetition += "금 "
            }
            if saturday {
                repetition += "토 "
            }
            if sunday {
                repetition += "일 "
            }
            print(repetition)
            //DataCenter.sharedInstnce.repetitionInfo.append(repetitionInfo(repetition: repetition))
           // print(eatingDay)
            delegate?.changeValue(monday: monday, tuesday: tuesday, wednesday: wednesday, thursday: thursday, friday: friday, saturday: saturday, sunday: sunday, eatingDay: eatingDay.text!, notEatingDay: notEatingDay.text!, repetition: repetition)
           // DataCenter.sharedInstnce.eatingDayInfo2.append(eatingDayInfo(eatingDay: eatingDay.text!, notEatingDay: notEatingDay.text!,monday: monday, tuesday: tuesday, wednesday: wednesday, thursday: thursday, friday: friday, saturday: saturday, sunday: sunday, repetition: repetition))
        }
    }
 
//    monday: monday, tuesday: tuesday, wednesday: wednesday, thursday: thursday, friday: friday, saturday: saturday, sunday: sunday, 

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
