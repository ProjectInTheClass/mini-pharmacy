//
//  DrugInfoTableViewController.swift
//  Parsing
//
//  Created by CAU on 31/01/2019.
//  Copyright © 2019 CAU AppDevelopment. All rights reserved.
//
//"http://apis.data.go.kr/1470000/DURPrdlstInfoService/getUsjntTabooInfoList?ServiceKey=7EUdxpIoOQDzou7Py2zLt%2Bbg4p18sYU4IhJhG7upo%2FSHhU0sZvCC1%2FTTmbw0RoMaamp8gFW%2BvecotrK0HGBm8g%3D%3D&numOfRows=100&pageNo=1"
import UIKit

class DrugInfoTableViewController: UITableViewController, XMLParserDelegate {
    var drugInfo = [String:String]()
//
    var drugItems = [[String : String]]() //  item Dictional Array
//    var drugItem = [String: String]()     //  item Dictionary
//    var xmlParser = XMLParser()
//    var currentElement = ""
//    var blank:Bool = false
//    var itemName = ""
//    var mixtureItemName = ""
//    var prohibitContent = ""
//
//    let totalCount = 3511
//
//    func requestMovieInfo(i:Int) {
//        // OPEN API 주소
//        let url = "http://apis.data.go.kr/1470000/DURPrdlstInfoService/getUsjntTabooInfoList?ServiceKey=7EUdxpIoOQDzou7Py2zLt%2Bbg4p18sYU4IhJhG7upo%2FSHhU0sZvCC1%2FTTmbw0RoMaamp8gFW%2BvecotrK0HGBm8g%3D%3D&numOfRows=100&pageNo="
//
//        var requestURL:String = url + String(i)
//        guard let xmlParser = XMLParser(contentsOf: URL(string: requestURL)!) else { return }
//
//        xmlParser.delegate = self
//        xmlParser.parse()
//
//    }
    
    @IBOutlet weak var drugName: UILabel!
    @IBOutlet weak var entpName: UILabel!
    @IBOutlet weak var classify: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        drugName.text = drugInfo["ITEM_NAME"]
        entpName.text = drugInfo["ENTP_NAME"]
        classify.text = drugInfo["CLASS_NO"]
        
//        for index in 1...totalCount{
//            requestMovieInfo(i: index)
//        }
        
    }

/*
    // XMLParserDelegate 함수
    // XML 파서가 시작 테그를 만나면 호출됨
    public func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:])
    {
        currentElement = elementName
        
        //        if (elementName == "item") {
        //            movieItem = [String : String]()
        //            itemName = ""
        //            entpName = ""
        //        }
        blank = true
    }
    
    // XML 파서가 종료 테그를 만나면 호출됨
    public func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?)
    {
        
        if (elementName == "item") {
            if itemName == drugInfo["ITEM_NAME"]{
            
            drugItem["ITEM_NAME"] = itemName
            drugItem["MIXTURE_ITEM_NAME"] = mixtureItemName
            drugItem["PROHBT_CONTENT"] = prohibitContent
            print(drugItem)
            drugItems.append(drugItem)
            }
        }
        blank = false
    }
    
    // 현재 테그에 담겨있는 문자열 전달
    public func parser(_ parser: XMLParser, foundCharacters string: String)
    {
        if (blank == true && currentElement == "ITEM_NAME") {
            itemName = string
        } else if (blank == true && currentElement == "MIXTURE_ITEM_NAME"){
            mixtureItemName = string
        } else if (blank == true && currentElement == "PROHBT_CONTENT"){
            prohibitContent = string
        }
        
    }
 */
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

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "drugInfoCell", for: indexPath)
        
        return cell
    }

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

 */
}
