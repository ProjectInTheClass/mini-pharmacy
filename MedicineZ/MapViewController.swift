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

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate, UISearchBarDelegate {
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var pharmacy = [Pharmacy]()
    var endTyping:Bool = false
    var searchName = ""
    
    
    
    func getJsonFromDirectory() {
        let path = Bundle.main.path(forResource: "pharmacy", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        do {
            let data = try Data(contentsOf: url)
            let jlist = try JSONDecoder().decode([Pharmacy].self, from: data)
            pharmacy = jlist
            print(pharmacy[0].dutyName!)
            
        } catch let err{
            print(err)
        }
        
    }
    
    
    /*지도*/
    
    
    //    var locations = [[String:Int]]()
    
    var coords : CLLocationCoordinate2D?
    
    var initialLocation = CLLocation()
    let locationManager = CLLocationManager()
    var geocoder = CLGeocoder()
    
    
    //json data
    //    do {
    //    if let file  = Bundle.main.url(forResource: "pharmacy", withExtension: "json"){
    //    let data  = try Data(contentsOf: file)
    //    let json = try JSONSerialization.jsonObject(with: data, options: [])
    //
    //    if let objects = json as? [Any]{
    //    for object in objects {
    //    dbData.append(<JsonFileInputClass>.dataFormJSONObject(json: object as! [String : AnyObject])!)
    //    }
    //    } else{
    //    print("JSON is invalid")
    //    }
    //    }else{
    //    print("no file")
    //    }
    //    }  catch {
    //    print(error.localizedDescription)
    //
    //    }
    
    
    
    @IBOutlet weak var myMap: MKMapView!
    
    var startLocation: CLLocation!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        searchBar.placeholder = "검색할 약국의 이름을 입력하세요."
        
        getJsonFromDirectory()
        //print(pharmacy[0].dutyName)
        
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
        //        let distanceBetween : CLLocationDistance = latestLocation.distance(from: startLocation) //두 CLLocation 지점간의 거리
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
    
    
    /* 현재 위치 표시 */
    
    @IBAction func sgChangeLocation(_ sender: UIBarButtonItem) {
        locationManager.startUpdatingLocation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //  getJsonFromDirectory()
        //        print(pharmacyInfo[0].dutyName)
        
        // MapViewController.readJSONFromFile (fileName: "pharmacy")
        
        for i in 0..<pharmacy.count {
            let annotation = MKPointAnnotation()
            annotation.title = pharmacy[i].dutyName
            annotation.coordinate = CLLocationCoordinate2D(latitude: Double(pharmacy[i].wgs84Lat!) ?? 0, longitude: pharmacy[i].wgs84Lon ?? 0)
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
    //검색기능
    func searchPharmacy(name: String) {
        for i in 0..<pharmacy.count {
            if pharmacy[i].dutyName == name {
                
                goLocation(latitude: Double(pharmacy[i].wgs84Lat!) ?? 0, longitude: pharmacy[i].wgs84Lon ?? 0, delta: 0.01)
            } else {
                
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
        
        //Ignoring user
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        //Activity Indicator
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = UIActivityIndicatorView.Style.gray
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        
        self.view.addSubview(activityIndicator)
        searchBar.resignFirstResponder()
        
        //Create the search request
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = searchBar.text
        
        let activeSearch = MKLocalSearch(request: searchRequest)
        activeSearch.start{ (response, error) in
            
            activityIndicator.stopAnimating()
            UIApplication.shared.endIgnoringInteractionEvents()
            
            if response == nil {
                print("ERROR")
            }
            else {
                //Remove annotations
                //                let annotations = self.myMap.annotaions
                //                self.myMap.removeAnnotations(annotations)
                
                //Getting data
                let latitude2 = response?.boundingRegion.center.latitude
                let longitude2 = response?.boundingRegion.center.longitude
                
                //Zooming in on annotation
                let coordinate:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude2!, longitude2!)
                let span = MKCoordinateSpan(latitudeDelta: 0.1,longitudeDelta: 0.1)
                self.goLocation(latitude: latitude2!, longitude: longitude2!, delta: 0.01)
                //                self.locationManager.stopUpdatingLocation()
                
            }
        }
        
        searchPharmacy(name: searchName)
        //  _ = searchBar.resignFirstResponder()
        
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar, didUpdateLocations locations: [CLLocation]) {
        searchBar.showsCancelButton = false
        searchBar.text = ""
        endTyping = false
        let pLocation = locations.last
        goLocation(latitude: (pLocation?.coordinate.latitude)!, longitude: (pLocation?.coordinate.longitude)!, delta: 0.01)
        //filteredDatas = [[String:String]]()
        // tableView.reloadData()
        //  _ = searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if(searchBarIsEmpty()){
            // filteredDatas = [[String:String]]()
            endTyping = false
            
        }
        
        return searchName = searchText
    }
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchBar.text?.isEmpty ?? true
    }
}
