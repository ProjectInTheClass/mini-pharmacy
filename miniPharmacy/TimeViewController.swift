//
//  TimeViewController.swift
//  MedicineZ
//
//  Created by CAU on 07/02/2019.
//  Copyright © 2019 CAU. All rights reserved.
//

import UIKit
/*
protocol AddAlarmViewDelegateProtocol {
    func changeLabel(alarmLabel:String)
}
 */
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
        // label.text = "\(alarmTime)"
        
        
       // delegate?.changeLabel(alarmLabel: alarmTime)
        self.dismiss(animated: true, completion: nil)
       // self.presentingViewController?.dismiss(animated: true, completion: nil)

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
}
