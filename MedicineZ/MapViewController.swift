
//
//  MapViewController.swift
//  MedicineZ
//
//  Created by CAU on 31/01/2019.
//  Copyright © 2019 CAU. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate, XMLParserDelegate {
    
    var xmlParser = XMLParser()
    
    var currentElement = ""                // 현재 Element
    var storeItems = [[String : String]]() // 약국 item Dictional Array
    var storeItem = [String: String]()     // 약국 item Dictionary
    var blank: Bool = false
    
    var dutyName = "" // 약국 이름
    var dutyAddr = "" // 약국 주소
    var dutyTel1 = "" // 약국 전화번호
    var wgs84Lat = "" // 약국 위도
    var wgs84Lon = "" // 약국 경도
    var dutyTime1c = "" // 평일 닫는 시간
    var dutyTime1s = "" // 평일 여는 시간
    //    var dutyTime2c = "" // 화요일 닫는 시간
    //    var dutyTime2s = "" // 화요일 여는 시간
    //    var dutyTime3c = "" // 수요일 닫는 시간
    //    var dutyTime3s = "" // 수요일 여는 시간
    //    var dutyTime4c = "" // 목요일 닫는 시간
    //    var dutyTime4s = "" // 목요일 여는 시간
    //    var dutyTime5c = "" // 금요일 닫는 시간
    //    var dutyTime5s = "" // 금요일 여는 시간
    var dutyTime6c = "" // 토요일 닫는 시간
    var dutyTime6s = "" // 토요일 여는 시간
    var dutyTime7c = "" // 일요일 닫는 시간
    var dutyTime7s = "" // 일요일 여는 시간
    var dutyTime8c = "" // 공휴일 닫는 시간
    var dutyTime8s = "" // 공휴일 여는 시간
    
    let totalEnteries = 231
    var limit = 20
    var index = 1
    
    //23051개의 데이터
    
    func requestStoreInfo(i:Int) {
        // OPEN API 주소
        let url = "http://apis.data.go.kr/B552657/ErmctInsttInfoInqireService/getParmacyFullDown?ServiceKey=RwTAsfYxRQL6Cc%2B0YC0SV91hEUl1mZRg8lbvZY%2FxV01GRy12jjqZ87mLC%2FkzFUNjiayFkHNwji7zyXljh2Ng%2FA%3D%3D&numOfRows=100&pageNo="
        
        var requestURL: String = url + String(i)
        guard let xmlParser = XMLParser(contentsOf: URL(string: url)!) else { return }
        
        xmlParser.delegate = self;
        xmlParser.parse()
    }
    
    // XMLParserDelegate 함수
    // XML 파서가 시작 테그를 만나면 호출됨
    public func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:])
    {
        currentElement = elementName
        //        if (elementName == "item") {
        //            storeItem = [String : String]()
        //            dutyName = ""
        //            dutyAddr = ""
        //            dutyTel1 = ""
        //            wgs84Lat = ""
        //            wgs84Lon = ""
        //            dutyTime1c = ""
        //            dutyTime1s = ""
        //            dutyTime6c = ""
        //            dutyTime6s = ""
        //            dutyTime7c = ""
        //            dutyTime7s = ""
        //            dutyTime8c = ""
        //            dutyTime8s = ""
        //        }
        blank = true
    }
    
    // XML 파서가 종료 테그를 만나면 호출됨
    public func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?)
    {
        if (elementName == "item") {
            storeItem["dutyName"] = dutyName;
            storeItem["dutyAddr"] = dutyAddr;
            storeItem["dutyTel1"] = dutyTel1;
            storeItem["wgs84Lat"] = wgs84Lat;
            storeItem["wgs84Lon"] = wgs84Lon;
            storeItem["dutyTime1c"] = dutyTime1c;
            storeItem["dutyTime1s"] = dutyTime1s;
            storeItem["dutyTime6c"] = dutyTime6c;
            storeItem["dutyTime6s"] = dutyTime6s;
            storeItem["dutyTime7c"] = dutyTime7c;
            storeItem["dutyTime7s"] = dutyTime7s;
            storeItem["dutyTime8c"] = dutyTime8c;
            storeItem["dutyTime8s"] = dutyTime8s;
            
            storeItems.append(storeItem)
        }
        
        blank = false
    }
    
    // 현재 테그에 담겨있는 문자열 전달
    public func parser(_ parser: XMLParser, foundCharacters string: String)
    {
        if (blank == true && currentElement == "dutyName") {
            dutyName = string
        } else if (blank == true && currentElement == "dutyAddr") {
            dutyAddr = string
        } else if (blank == true && currentElement == "dutyTel1"){
            dutyTel1 = string
        } else if (blank == true && currentElement == "wgs84Lat"){
            wgs84Lat = string
        } else if (blank == true && currentElement == "wgs84Lon"){
            wgs84Lon = string
        } else if (blank == true && currentElement == "dutyTime1c"){
            dutyTime1c = string
        } else if (blank == true && currentElement == "dutyTime1s"){
            dutyTime1s = string
        } else if (blank == true && currentElement == "dutyTime6c"){
            dutyTime6c = string
        } else if (blank == true && currentElement == "dutyTime6s"){
            dutyTime6s = string
        } else if (blank == true && currentElement == "dutyTime7c"){
            dutyTime7c = string
        } else if (blank == true && currentElement == "dutyTime7s"){
            dutyTime7s = string
        } else if (blank == true && currentElement == "dutyTime8c"){
            dutyTime8c = string
        } else if (blank == true && currentElement == "dutyTime8s"){
            dutyTime8s = string
        }
    }
    
    
    
    // MARK: - Table view data source
    
    //    override func numberOfSections(in tableView: UITableView) -> Int {
    //        // #warning Incomplete implementation, return the number of sections
    //        return 1
    //    }
    //
    //    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    //        // #warning Incomplete implementation, return the number of rows
    //        return self.storeItems.count
    //    }
    //
    //
    //
    //    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    //        let cell = tableView.dequeueReusableCell(withIdentifier: "storeCell", for: indexPath)
    //
    //        // Configure the cell...
    //        cell.textLabel?.text = storeItems[indexPath.row]["dutyName"]
    //        cell.detailTextLabel?.text = storeItems[indexPath.row]["dutyAddr"]
    //
    //        return cell
    //    }
    
    /*지도*/
    
    
    //    var locations = [[String:Int]]()
    
    var coords : CLLocationCoordinate2D?
    
    var initialLocation = CLLocation()
    let locationManager = CLLocationManager()
    var geocoder = CLGeocoder()
    
    
    @IBOutlet weak var myMap: MKMapView!
    
    var startLocation: CLLocation!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //파싱
        for i in 1...5{
        requestStoreInfo(i: i)
        }
        // Do any additional setup after loading the view.
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest //배터리로 동작할 때 권장되는 가장 높은 수준의 정확도
        locationManager.requestWhenInUseAuthorization() // 위치 접근 허가 요청(어플리케이션이 포그라운드에 있을때만)
        locationManager.startUpdatingLocation() //위치 업데이트 시작
        myMap.showsUserLocation = true
        startLocation = nil
        
        locationManager.distanceFilter = 100 // 위치가 100미터 바뀔 때마다 애플리케이션이 알림 받음.
        
        
        
        //        for (latitude2, longitude2) in locations {
        //            let findLocation = CLLocation(latitude: latitude2, longitude: longitude2)
        //            let geocoder = CLGeocoder()
        //            let locale = Locale(identifier: "Ko-kr") //원하는 언어의 나라 코드 넣어주기
        //            geocoder.reverseGeocodeLocation(findLocation, preferredLocale: locale, completionHandler: {(placemarks, error) in
        //                if let address:[CLPlacemark] = placemarks {
        //                    if let name: String = address.last?.name {print(name)} //전체 주소
        //                }
        //            })
        //        }
    }
    
    //    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
    //
    //        var annotationView = myMap.dequeueReusableAnnotationView(withIdentifier: "Museum")
    //
    //        if annotationView == nil{
    //            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "Museum")
    //            annotationView?.image = UIImage(named: "gps")
    //            annotationView?.canShowCallout = false
    //
    //        }else{
    //            annotationView!.annotation = annotation
    //        }
    //        return annotationView
    //    }
    
    
    func goLocation(latitude latitudeValue: CLLocationDegrees, longitude longitudeValue: CLLocationDegrees, delta span: Double) -> CLLocationCoordinate2D {
        let pLocation = CLLocationCoordinate2DMake(latitudeValue, longitudeValue)
        let spanValue = MKCoordinateSpan(latitudeDelta: span, longitudeDelta: span)
        let pRegion = MKCoordinateRegion(center: pLocation, span: spanValue)
        myMap.setRegion(pRegion, animated: true)
        return pLocation
        
    }
    /* 위도와 경도로 원하는 핀 설치하기 */
    func setAnnotation(latitude latitudeValue: CLLocationDegrees, longitude longitudeValue: CLLocationDegrees, delta span :Double, title strTitle: String, subtitle strSubtitle:String) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = goLocation(latitude: latitudeValue, longitude: longitudeValue, delta: span)
        annotation.title = strTitle
        annotation.subtitle = strSubtitle
        myMap.addAnnotation(annotation)
    }
    //CLLocationManagerDelegate 델리게이트 함수 시작
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let latestLocation : AnyObject = locations[locations.count - 1]
        let pLocation = locations.last
        goLocation(latitude: (pLocation?.coordinate.latitude)!, longitude: (pLocation?.coordinate.longitude)!, delta: 0.01)
        
        if startLocation == nil {
            startLocation = latestLocation as? CLLocation
        }
        let distanceBetween : CLLocationDistance = latestLocation.distance(from: startLocation) //두 CLLocation 지점간의 거리
        /*
         /*위치 정보 추출해 텍스트로 표시하기 */
         //위도와 경도값으로 주소 찾기
         CLGeocoder().reverseGeocodeLocation(pLocation!, completionHandler: {
         (placemarks, error) -> Void in
         let pm = placemarks!.first
         let country = pm!.country
         var address:String = country!
         //            if pm!.locality != nil {
         //                address += " "
         //                address += pm!.thoroughfare!
         //            }
         
         })
         */
        locationManager.stopUpdatingLocation() //위치 업데이트 중지
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: NSError) {
        print("GPS 에러 발생. \(error.localizedDescription)")
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        //애플리케이션의 위치 추적 허가 상태가 변경될 경우 호출
        
        locationManager.requestWhenInUseAuthorization() // 위치 접근 허가 요청(어플리케이션이 포그라운드에 있을때만)
    }
    
    //CLLocationManagerDelegate 델리게이트 함수 끝
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    /* 현재 위치 표시 */
    
    @IBAction func sgChangeLocation(_ sender: UIBarButtonItem) {
        locationManager.startUpdatingLocation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        for i in 0..<storeItems.count {
            let annotation = MKPointAnnotation()
            annotation.title = storeItems[i]["dutyName"]
            annotation.coordinate = CLLocationCoordinate2D(latitude: Double(storeItems[i]["wgs84Lat"]!)!, longitude: Double(storeItems[i]["wgs84Lon"]!)!)
            myMap.isZoomEnabled = true // 줌 가능
            myMap.isScrollEnabled = true // 스크롤 가능
            //let cood = myMap.centerCoordinate // 중앙 좌표 얻기
            myMap.addAnnotation(annotation)
        }
    }
    
    //콜아웃(어노테이션 정보)에 버튼 추가 및 tag이용해 어떤 버튼 눌렸는지 알기
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        var annotationView = myMap.dequeueReusableAnnotationView(withIdentifier: "Museum")
        
        if annotationView == nil{
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "Museum")
            annotationView?.canShowCallout = true
            
            let btn = UIButton(type: UIButton.ButtonType.infoLight)
            annotationView?.rightCalloutAccessoryView = btn
            btn.tag = 1
            let btn2 = UIButton(type: UIButton.ButtonType.infoLight)
            annotationView?.leftCalloutAccessoryView = btn2
            btn2.tag = 2
            
            
        }else{
            annotationView!.annotation = annotation
        }
        return annotationView
        
    }
    //콜아웃 버튼 누른 곳 알기
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let annotation = view.annotation!
        print("버튼을 누른 곳은 : " , annotation.title!, control.tag)
    }
    
    
}
