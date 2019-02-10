//
//  DrugAddTableViewController.swift
//  MedicineZ
//
//  Created by CAU on 08/02/2019.
//  Copyright © 2019 CAU. All rights reserved.
//

import UIKit
protocol AddAlarmViewDelegateProtocol2 {
    func addDrugList(drugItem: [String:String])
    
}

class DrugAddTableViewController: UITableViewController, UISearchBarDelegate, XMLParserDelegate {

    var delegate:AddAlarmViewDelegateProtocol2?

    //searching
    @IBOutlet var searchBar: UISearchBar!
    var filteredDatas = [[String : String]]()
    var filteredData = [String : String]()
    var endTyping:Bool = false
    var searchName = ""
    //xmlParsing
    var xmlParser = XMLParser()
    var currentElement = ""                // 현재 Element
    var drugItems = [[String : String]]() //  item Dictional Array
    var drugItem = [String: String]()     //  item Dictionary
    var blank:Bool = false
    var itemName = "" // 약 이름
    var entpName = "" // 회사이름
    var classify = "" // 분류
    var manual = "" // 약 설명서
    var itemIndex:Int = 1
    
    var selectedData = [String:String]()
    var selectedIndexPath = IndexPath(row: 0, section: 0)
    
    let totalEnteries = 2750
    var limit = 20
    var index = 1
    
    @IBAction func selectDrug(_ sender: Any) {
        delegate?.addDrugList(drugItem: selectedData)
        let alert = UIAlertController(title: "선택", message: "선택되었습니다.", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "확인", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func requestDrugInfo(i:Int) {
        // OPEN API 주소
        let url = "http://apis.data.go.kr/1470000/DURPrdlstInfoService/getDurPrdlstInfoList?ServiceKey=7EUdxpIoOQDzou7Py2zLt%2Bbg4p18sYU4IhJhG7upo%2FSHhU0sZvCC1%2FTTmbw0RoMaamp8gFW%2BvecotrK0HGBm8g%3D%3D&numOfRows=20&pageNo="
        
        var requestURL:String = url + String(i)
        guard let xmlParser = XMLParser(contentsOf: URL(string: requestURL)!) else { return }
        
        xmlParser.delegate = self
        xmlParser.parse()
        
    }
    func searchDrugInfo(itemName:String) {
        // OPEN API 주소
        let url = "http://apis.data.go.kr/1470000/DURPrdlstInfoService/getDurPrdlstInfoList?ServiceKey=7EUdxpIoOQDzou7Py2zLt%2Bbg4p18sYU4IhJhG7upo%2FSHhU0sZvCC1%2FTTmbw0RoMaamp8gFW%2BvecotrK0HGBm8g%3D%3D&itemName="
        var encode = String(itemName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
        var requestURL:String = url + encode
        guard let xmlParser = XMLParser(contentsOf: URL(string: requestURL)!) else { return }
        
        xmlParser.delegate = self
        xmlParser.parse()
        self.tableView.reloadData()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        searchBar.placeholder = "검색할 약의 이름을 입력하세요."
        requestDrugInfo(i: index)
        index += 1
        tableView.reloadData()
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if self.navigationController?.topViewController != self {
        }
    }
    
    // XMLParserDelegate 함수
    // XML 파서가 시작 테그를 만나면 호출됨
    public func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:])
    {
        currentElement = elementName
        if(endTyping){
            if (elementName == "item") {
                filteredData = [String : String]()
                itemName = "" // 약 이름
                entpName = "" // 회사이름
                classify = "" // 분류
                manual = "" // 약 설명서
                itemIndex = 1
            }
            blank = true
        }else{
            if (elementName == "item") {
                drugItem = [String : String]()
                itemName = "" // 약 이름
                entpName = "" // 회사이름
                classify = "" // 분류
                manual = "" // 약 설명서
                itemIndex = 1
            }
            blank = true
            
        }
    }
    
    // XML 파서가 종료 테그를 만나면 호출됨
    public func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?)
    {
        if(endTyping){
            if (elementName == "item") {
                filteredData["ITEM_NAME"] = itemName
                filteredData["ENTP_NAME"] = entpName
                filteredData["CLASS_NO"] = classify
                filteredData["INSERT_FILE"] = manual
                filteredDatas.append(filteredData)
                
            }
            blank = false
        }else{
            if (elementName == "item") {
                drugItem["ITEM_NAME"] = itemName
                drugItem["ENTP_NAME"] = entpName
                drugItem["CLASS_NO"] = classify
                drugItem["INSERT_FILE"] = manual
                
                drugItems.append(drugItem)
                
            }
            blank = false
            
        }
    }
    
    // 현재 테그에 담겨있는 문자열 전달
    public func parser(_ parser: XMLParser, foundCharacters string: String)
    {
        if(endTyping){
            if (blank == true && currentElement == "ITEM_NAME") {
                if (itemIndex == 1){
                    itemName = string
                }
                itemIndex += 1
            } else if (blank == true && currentElement == "ENTP_NAME") {
                entpName = string
            } else if (blank == true && currentElement == "CLASS_NO"){
                classify = string
            } else if (blank == true && currentElement == "INSERT_FILE"){
                manual = string
            }
        }else{
            if (blank == true && currentElement == "ITEM_NAME") {
                if (itemIndex == 1){
                    itemName = string
                }
                itemIndex += 1
            } else if (blank == true && currentElement == "ENTP_NAME") {
                entpName = string
            } else if (blank == true && currentElement == "CLASS_NO"){
                classify = string
            } else if (blank == true && currentElement == "INSERT_FILE"){
                manual = string
            }
            
        }
        
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsSearchResultsButton = true
        searchBar.showsCancelButton = true
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        endTyping = true
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        endTyping = true
        searchDrugInfo(itemName: searchName)
        _ = searchBar.resignFirstResponder()
        
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = ""
        endTyping = false
        filteredDatas = [[String:String]]()
        tableView.reloadData()
        _ = searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if(searchBarIsEmpty()){
            filteredDatas = [[String:String]]()
            endTyping = false
            tableView.reloadData()
        }
        
        return searchName = searchText
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if  (!searchBarIsEmpty() && endTyping) {
            return filteredDatas.count
            
        } else {
            return self.drugItems.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "drugCell", for: indexPath)
        
        // Configure the cell..
        if indexPath == selectedIndexPath {
            cell.accessoryType = .checkmark
            if (!searchBarIsEmpty() && endTyping) {
                selectedData = filteredDatas[selectedIndexPath.row]
            }else{
                selectedData = drugItems[selectedIndexPath.row]
            }
        } else {
            cell.accessoryType = .none
        }
        
        if (!searchBarIsEmpty() && endTyping) {
            cell.textLabel?.text = filteredDatas[indexPath.row]["ITEM_NAME"]
            cell.detailTextLabel?.text = filteredDatas[indexPath.row]["ENTP_NAME"]
            
            return cell
        }
        else {
            cell.textLabel?.text = drugItems[indexPath.row]["ITEM_NAME"]
            cell.detailTextLabel?.text = drugItems[indexPath.row]["ENTP_NAME"]
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if (!searchBarIsEmpty() && endTyping) {
            
        }else{
            if indexPath.row == self.drugItems.count - 1 {
                // we are at last cell load more content
                if self.drugItems.count < totalEnteries {
                    // we need to bring more records as there are some pending records available
                    limit = index + 1
                    while index < limit{
                        requestDrugInfo(i: index)
                        index += 1
                        
                    }
                    self.perform(#selector(loadTable), with: nil, afterDelay: 1.0)
                }
            }
            
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath == selectedIndexPath{
            return
        }
        if let newCell = tableView.cellForRow(at: indexPath) {
            if newCell.accessoryType == .none
            {
                newCell.accessoryType = .checkmark
            }
        }
        if let oldCell = tableView.cellForRow(at: selectedIndexPath){
            if oldCell.accessoryType == .checkmark{
                oldCell.accessoryType = .none
            }
        }
        selectedIndexPath = indexPath
        self.tableView.reloadData()
    }
    
    
    @objc func loadTable() {
        self.tableView.reloadData()
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//        if let detailVC = segue.destination as? DrugInfoTableViewController{
//
//            if let drugIdx = self.tableView.indexPathForSelectedRow{
//                if (!searchBarIsEmpty() && endTyping) {
//                    detailVC.drugInfo = filteredDatas[drugIdx.row]
//
//                }else{
//                    detailVC.drugInfo = drugItems[drugIdx.row]
//                }
//            }
//        }
//
//    }
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchBar.text?.isEmpty ?? true
    }
    

}
