//
//  CHPickerViewController.swift
//  PilotPlantSwift
//
//  Created by lingostar on 2014. 10. 28..
//  Copyright (c) 2014년 lingostar. All rights reserved.
//

import UIKit


open class PickerScene: UIViewController , UIPickerViewDataSource, UIPickerViewDelegate {
    @IBInspectable open var column : Int = 1
    @IBInspectable open var plistName : String = ""
    
    var pickerCollection : AnyObject? = nil
    var pickerView : UIPickerView = UIPickerView()
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let filePath = Bundle.main.path(forResource: plistName, ofType: "plist") {
            if column > 1 {
                pickerCollection = NSDictionary(contentsOfFile: filePath)
            } else {
                pickerCollection = NSArray(contentsOfFile: filePath)
            }
        }
        
        for view in self.view.subviews {
            if view is UIPickerView {
                pickerView = view as! UIPickerView
            }
        }
        
        if pickerView.superview == nil {
            self.view.addSubview(pickerView)
        }
        
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
    //Replace it with AutoLayout
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        pickerView.center = self.view.center
    }
    
    func keyArray(_ collection: AnyObject, component: Int, selection: Int = 0) -> [String]? {
        if let returnArray = collection as? [String] {
            return returnArray.sorted{$0.localizedCaseInsensitiveCompare($1 as String) == ComparisonResult.orderedAscending}
        } else if let lastDictionary = collection as? NSDictionary {
            if selection == component {
                let keyArray : NSArray = collection.allKeys as NSArray
                let returnArray : [String] = keyArray as! [String]
                return returnArray
                //return returnArray.sorted{$0.localizedCaseInsensitiveCompare($1 as String) == NSComparisonResult.OrderedAscending}
            } else {
                let selectedRow = pickerView.selectedRow(inComponent: selection)
                let selectedKey : String = collection.allKeys[selectedRow] as! String
                let selectedCollection = collection.value(forKey: selectedKey)
                return keyArray(selectedCollection! as AnyObject, component: component, selection:selection+1)
            }
        }
        return nil
    }

    
    func arrayForComponent (_ component : Int) -> [String]? {
        return keyArray(pickerCollection!, component: component)
    }
    
    open func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var rows:Int = 0
        if let array = arrayForComponent(component) {
            rows = array.count
        }
        return rows
    }
    
    open func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        var rowTitle:String! = nil
        if let array = arrayForComponent(component) {
            rowTitle = array[row]
        }
        return rowTitle
    }
    
    
    open func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerView.reloadAllComponents()
    }
    
    open func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return column
    }
}


open class CHPickerView: UIView, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBInspectable open var column : Int = 1
    @IBInspectable open var plistName : String = ""
    
    var pickerCollection : AnyObject? = nil
    var pickerView : UIPickerView = UIPickerView()
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        
        if let filePath = Bundle.main.path(forResource: plistName, ofType: "plist") {
            if column > 1 {
                pickerCollection = NSDictionary(contentsOfFile: filePath)
            } else {
                pickerCollection = NSArray(contentsOfFile: filePath)
            }
        }
        
        for view in self.subviews {
            if view is UIPickerView {
                pickerView = view as! UIPickerView
            }
        }
        
        if pickerView.superview == nil {
            self.addSubview(pickerView)
        }
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        pickerView.center = self.center
        
    }
    
    override open var intrinsicContentSize: CGSize {
        return pickerView.intrinsicContentSize
    }
    
    open override func layoutSubviews() {
        pickerView.reloadAllComponents()
    }
    
    func keyArray(_ collection: AnyObject, component: Int, selection: Int = 0) -> [String]? {
        if let returnArray = collection as? [String] {
            return returnArray.sorted{$0.localizedCaseInsensitiveCompare($1 as String) == ComparisonResult.orderedAscending}
        } else if let lastDictionary = collection as? NSDictionary {
            if selection == component {
                let keyArray : NSArray = collection.allKeys as NSArray
                let returnArray : [String] = keyArray as! [String]
                return returnArray
                //return returnArray.sorted{$0.localizedCaseInsensitiveCompare($1 as String) == NSComparisonResult.OrderedAscending}
            } else {
                let selectedRow = pickerView.selectedRow(inComponent: selection)
                let selectedKey : String = collection.allKeys[selectedRow] as! String
                let selectedCollection = collection.value(forKey: selectedKey)
                return keyArray(selectedCollection! as AnyObject, component: component, selection:selection+1)
            }
        }
        return nil
    }
    
    func arrayForComponent (_ component : Int) -> [String]? {
        return keyArray(pickerCollection!, component: component)
    }
    
    open func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var rows:Int = 0
        if let array = arrayForComponent(component) {
            rows = array.count
        }
        return rows
    }
    
    open func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        var rowTitle:String! = nil
        if let array = arrayForComponent(component) {
            rowTitle = array[row]
        }
        return rowTitle
    }
    
    
    open func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerView.reloadAllComponents()
    }
    
    open func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return column
    }
}
