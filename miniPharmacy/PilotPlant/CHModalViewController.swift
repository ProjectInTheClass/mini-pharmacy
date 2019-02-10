//
//  CHAlertViewController.swift
//  PilotPlant
//
//  Created by Lingostar on 2015. 12. 5..
//  Copyright © 2015년 LingoStar. All rights reserved.
//

import UIKit


open class AlertScene: UIViewController {
    @IBInspectable open var alertStyle:Bool = false
    @IBInspectable open var alertTitle:String = ""
    @IBInspectable open var message:String = ""
    @IBInspectable open var redButton:String? = nil
    @IBInspectable open var buttonNames:String = ""
    
    var alertController:UIAlertController!
    open override func viewDidAppear(_ animated: Bool) {
        let style:UIAlertController.Style = (alertStyle ? .alert : .actionSheet)
        
        alertController = UIAlertController(title: alertTitle, message: message, preferredStyle: style)
        
        if let redActionName = redButton {
            let redAction = UIAlertAction(title: redActionName, style: .destructive, handler: nil)
            alertController.addAction(redAction)
        }
        
        let buttonNameArray = buttonNames.components(separatedBy: ",")
        buttonNameArray.map({
            let action = UIAlertAction(title: $0, style: .default, handler: nil)
            alertController.addAction(action)
        })
        
        self.present(alertController, animated: true, completion: nil)
    }
    
}

open class ActivityScene: UIViewController {
    @IBInspectable open var name:String = "AppName"
    @IBInspectable open var activityIcon:String = "LS_Profile"
    
    
    open override func viewDidAppear(_ animated: Bool) {
        
        let string: String = "Hello"
        let URL = Foundation.URL(string:"http://www.codershigh.com")!
        let activity = CustomActivity(name: name, icon: activityIcon)
        
        let activityViewController = UIActivityViewController(activityItems: [string, URL], applicationActivities: [activity])
        navigationController?.present(activityViewController, animated: true) {
        }
    }
    

    class CustomActivity: UIActivity {
        
        var name_nested:String
        var activityIcon_nested:String
        
        init(name:String, icon:String) {
            name_nested = name
            activityIcon_nested = icon
        }
        
        override var activityType : UIActivity.ActivityType? {
            return UIActivity.ActivityType("lingostar.pilotplant.com")
        }
        
        override var activityTitle : String? {
            return name_nested
        }
        
        override var activityImage : UIImage? {
            return UIImage(named: activityIcon_nested)
        }
        
        override func canPerform(withActivityItems activityItems: [Any]) -> Bool {
            return true
        }
        
        override func perform() {
            
        }
    }
}



open class PopoverHostScene:UIViewController, UIPopoverPresentationControllerDelegate
{
    override open func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "popoverSegue" {
            let popoverViewController = segue.destination 
            popoverViewController.modalPresentationStyle = UIModalPresentationStyle.popover
            popoverViewController.popoverPresentationController!.delegate = self
        }
    }
    
    open func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }
}
