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

    var drugItems = [[String : String]]()
    
    @IBOutlet weak var drugName: UILabel!
    @IBOutlet weak var entpName: UILabel!
    @IBOutlet weak var classify: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        drugName.text = drugInfo["ITEM_NAME"]
        entpName.text = drugInfo["ENTP_NAME"]
        classify.text = drugInfo["CLASS_NO"]
    
        
    }


    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section {
        case 0:
            return drugInfo.count
        case 1:
            return drugItems.count
        default:
            return 0
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if let detailVC = segue.destination as? WebViewController{
            detailVC.manualUrl = drugInfo["INSERT_FILE"] ?? ""
        }
    }

}
