//
//  PharmacyDetailsViewController.swift
//  MedicineZ
//
//  Created by CAU on 13/02/2019.
//  Copyright © 2019 CAU. All rights reserved.
//

import UIKit

class PharmacyDetailsViewController: UIViewController {

    @IBOutlet weak var pharmacyName: UILabel!
    @IBOutlet weak var pharmacyNumber: UILabel!
    @IBOutlet weak var pharmacyAddress: UILabel!
    @IBOutlet weak var viewInfo: UIView!
    @IBOutlet weak var pharmacyTime: UILabel!
    @IBOutlet weak var holidayTime: UILabel!
    
    var name = ""
    var number = ""
    var address = ""
    var startTime = ""
    var closeTime = ""
    var holidayStart = ""
    var holidayClose = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        pharmacyName.text = name
        pharmacyNumber.text = number
        pharmacyAddress.text = address
        if startTime.characters.count == 3 {
            pharmacyTime.text = "운영시간 " + String(startTime.prefix(1)) + ":" + String(startTime.suffix(2)) + " ~ "         } else {
            pharmacyTime.text = "운영시간 " + String(startTime.prefix(2)) + ":" + String(startTime.suffix(2)) + " ~ "
        }
        if closeTime.characters.count == 3 {
            pharmacyTime.text! += String(closeTime.prefix(1)) + ":" + String(closeTime.suffix(2))
        } else {
            pharmacyTime.text! += String(closeTime.prefix(2)) + ":" + String(closeTime.suffix(2))
        }
//        pharmacyTime.text = "운영시간 : " + startTime + "~" + closeTime
        if holidayStart == "0" {
            holidayTime.text = "공휴일에는 열지 않아요!"
        } else {
            if holidayStart.characters.count == 3 {
                holidayTime.text = "공휴일 " + String(holidayStart.prefix(1)) + ":" + String(holidayStart.suffix(2)) + " ~ "
                
            } else {
                holidayTime.text = "공휴일 " + String(holidayStart.prefix(2)) + ":" + String(holidayStart.suffix(2)) + " ~ " 
            }
            if holidayClose.characters.count == 3 {
                holidayTime.text! += String(holidayClose.prefix(1)) + ":" + String(holidayClose.suffix(2))
            } else {
                holidayTime.text! += String(holidayClose.prefix(2)) + ":" + String(holidayClose.suffix(2))
            }
        }
        
    }
    @objc func dismissModal(){
        self.dismiss(animated: true, completion: nil)
    }
    

}
