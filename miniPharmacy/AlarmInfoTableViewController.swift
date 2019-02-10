//
//  AlarmInfoTableViewController.swift
//  MedicineZ
//
//  Created by CAU on 10/02/2019.
//  Copyright © 2019 CAU. All rights reserved.
//

import UIKit

class AlarmInfoTableViewController: UITableViewController {
    var alarmInfoName:String = ""
    var alarmInfoTime:String = ""
    var alarmInfoWhen:String = ""
    var alarmInfoRepetition:String = ""
    var alarmInfoMemo:String = ""
    var alarmInfoEatingDay:String = ""
    var alarmInfoNotEatingDay:String = ""

    @IBOutlet weak var alarmName: UILabel!
    @IBOutlet weak var alarmTime: UILabel!
    @IBOutlet weak var when: UILabel!
    @IBOutlet weak var repetition: UILabel!
    @IBOutlet weak var memo: UILabel!
    @IBOutlet weak var eatingDay: UILabel!
    @IBOutlet weak var notEatingDay: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        alarmName.text = alarmInfoName
        alarmTime.text = alarmInfoTime
        when.text = alarmInfoWhen
        repetition.text = alarmInfoRepetition
        memo.text = alarmInfoMemo
        eatingDay.text = "복약일 : " + alarmInfoEatingDay
        notEatingDay.text = "휴약일 : " + alarmInfoNotEatingDay

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }


        
    }
    // MARK: - Table view data source
/*
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
*/
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


