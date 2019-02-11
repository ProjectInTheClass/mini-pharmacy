//
//  TimeViewController.swift
//  MedicineZ
//
//  Created by CAU on 07/02/2019.
//  Copyright © 2019 CAU. All rights reserved.
//

import UIKit

class TimeViewController: UIViewController {
    
    var delegate:AddAlarmViewDelegateProtocol?
    
    @IBOutlet weak var picker: UIDatePicker!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func getDate(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "a hh:mm"
        var alarmTime = dateFormatter.string(from: picker.date)
        self.dismiss(animated: true, completion: nil)

    }
}
