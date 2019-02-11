//
//  EditAlarmRepetitionTableViewController.swift
//  MedicineZ
//
//  Created by CAU on 11/02/2019.
//  Copyright © 2019 CAU. All rights reserved.
//

import UIKit

protocol EditAlarmRepetitionProtocol {
    func changeValue(eatingDay: String, notEatingDay: String, repetition: String)
}

class EditAlarmRepetitionTableViewController: UITableViewController, UITextFieldDelegate {

    var delegate:EditAlarmRepetitionProtocol?
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
        
    }
    
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
            delegate?.changeValue(eatingDay: eatingDay.text!, notEatingDay: notEatingDay.text!, repetition: repetition)
        }
    }
    

}
