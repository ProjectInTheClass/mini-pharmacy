//
//  OTPViewController.swift
//  MedicineZ
//
//  Created by CAU on 12/02/2019.
//  Copyright © 2019 CAU. All rights reserved.
//

import UIKit

class OTPViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var txt1: UITextField!
    @IBOutlet weak var txt2: UITextField!
    @IBOutlet weak var txt3: UITextField!
    @IBOutlet weak var txt4: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        txt1.backgroundColor = UIColor.clear
        txt2.backgroundColor = UIColor.clear
        txt3.backgroundColor = UIColor.clear
        txt4.backgroundColor = UIColor.clear
        
        
        txt1.delegate = self
        txt2.delegate = self
        txt3.delegate = self
        txt4.delegate = self
        
        border(textField: txt1)
        border(textField: txt2)
        border(textField: txt3)
        border(textField: txt4)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if ((textField.text?.count)! < 1) && (string.count > 0) {
            
            if textField == txt1 {
                txt2.becomeFirstResponder()
            }
            if textField == txt2 {
                txt3.becomeFirstResponder()
            }
            if textField == txt3 {
                txt4.becomeFirstResponder()
            }
            if textField == txt4 {
                txt4.becomeFirstResponder()
                self.dismiss(animated: true, completion: nil)
            }
            textField.text = string
            
            return false
        }
        
        else if ((textField.text?.count)! >= 1) && (string.count == 0) {
            
            if textField == txt2 {
                txt1.becomeFirstResponder()
            }
            if textField == txt3 {
                txt2.becomeFirstResponder()
            }
            if textField == txt4 {
                txt3.becomeFirstResponder()
            }
            if textField == txt1 {
                txt1.becomeFirstResponder()
            }
            textField.text = ""
            return false
            
        }
    
        else if (textField.text?.count)! >= 1 {
            textField.text = string
            return false
        }
        return true
        
    }

    func border(textField: UITextField) {
        
        let layer = CALayer()
        layer.frame = CGRect(x: 0.0, y: textField.frame.size.height - 2.0, width: textField.frame.size.width - 1.0, height: 2.0)
        layer.backgroundColor = UIColor.gray.cgColor
        
        textField.layer.addSublayer(layer)
    }
    
}
