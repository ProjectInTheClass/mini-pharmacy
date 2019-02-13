//
//  DrugInfoTableViewController.swift
//  Parsing
//
//  Created by CAU on 31/01/2019.
//  Copyright © 2019 CAU AppDevelopment. All rights reserved.
//

import UIKit

class DrugInfoTableViewController: UITableViewController, XMLParserDelegate {
    var drugInfo = [String:String]()

    
    @IBOutlet weak var drugName: UILabel!
    @IBOutlet weak var entpName: UILabel!
    @IBOutlet weak var classify: UILabel!
    @IBOutlet weak var manual: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        drugName.text = drugInfo["ITEM_NAME"]
        entpName.text = drugInfo["ENTP_NAME"]
        classify.text = drugInfo["CLASS_NO"]
        if drugInfo["INSERT_FILE"] == "http://www.health.kr/images/insert_pdf/"{
            manual.text = "약 설명서가 등록되어 있지 않았어요!"
            manual.textColor = UIColor.red
        }else{
            manual.text = "약 설명서가 등록되어 있어요!"
            manual.textColor = UIColor(red:0.21, green:0.68, blue:0.91, alpha:1.0)
        }
        
    }


    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
       
        return drugInfo.count
       
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if let detailVC = segue.destination as? WebViewController{
            detailVC.manualUrl = drugInfo["INSERT_FILE"] ?? ""
        }
    }

}
