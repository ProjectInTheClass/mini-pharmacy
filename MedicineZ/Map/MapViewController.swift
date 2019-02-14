
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
    
    var initialLocation = CLLocation()
    let locationManager = CLLocationManager()
    var geocoder = CLGeocoder()
    var coor = CLLocationCoordinate2D()
    var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    
    @IBOutlet weak var myMap: MKMapView!
    
    var startLocation: CLLocation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        searchBar.placeholder = "검색할 위치나 약국의 이름을 입력하세요."
        
        getJsonFromDirectory()
        
        // Do any additional setup after loading the view.
        myMap.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest //배터리로 동작할 때 권장되는 가장 높은 수준의 정확도
        locationManager.requestWhenInUseAuthorization() // 위치 접근 허가 요청(어플리케이션이 포그라운드에 있을때만)
        locationManager.startUpdatingLocation() //위치 업데이트 시작
        myMap.showsUserLocation = true
        startLocation = nil
        
        locationManager.distanceFilter = 100 // 위치가 100미터 바뀔 때마다 애플리케이션이 알림 받음.
        
        for i in 0..<pharmacy.count {
            let annotation = MKPointAnnotation()
            annotation.title = pharmacy[i].dutyName
            annotation.subtitle = pharmacy[i].dutyTel1!
            annotation.coordinate = CLLocationCoordinate2D(latitude: Double(pharmacy[i].wgs84Lat!) ?? 0, longitude: pharmacy[i].wgs84Lon ?? 0)
            myMap.isZoomEnabled = true // 줌 가능
            myMap.isScrollEnabled = true // 스크롤 가능
            //let cood = myMap.centerCoordinate // 중앙 좌표 얻기
            myMap.addAnnotation(annotation)
        }
        
        
    }
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation.isEqual(myMap.userLocation) {
            return nil
        }
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "pharmacy")
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "pharmacy")
            annotationView!.canShowCallout = true
        }
        else {
            annotationView!.annotation = annotation
        }
        let pinImage = UIImage(named: "ma")
        annotationView!.image = pinImage
        annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        return annotationView
        
    }
    
    
    func goLocation(latitude latitudeValue: CLLocationDegrees, longitude longitudeValue: CLLocationDegrees, delta span: Double) -> CLLocationCoordinate2D {
        let pLocation = CLLocationCoordinate2DMake(latitudeValue, longitudeValue)
        let spanValue = MKCoordinateSpan(latitudeDelta: span, longitudeDelta: span)
        let pRegion = MKCoordinateRegion(center: pLocation, span: spanValue)
        myMap.setRegion(pRegion, animated: true)
        return pLocation
        
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
        
    }
    
    //when the button is tapped we want to perform a segue
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let annView = view.annotation
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailVC = storyboard.instantiateViewController(withIdentifier: "Detail") as! PharmacyDetailsViewController
        
        detailVC.name = (annView?.title!)!
        detailVC.number = ((annView?.subtitle!)!)
        let navBarOnModal = UINavigationController(rootViewController: detailVC)
        let cal = Calendar(identifier: .gregorian)
        let now = Date()
        let comps = cal.dateComponents([.weekday], from: now)
        
        for i in 0..<pharmacy.count {
            if detailVC.number == pharmacy[i].dutyTel1 {
                detailVC.address = pharmacy[i].dutyAddr!
                detailVC.holidayStart = String(pharmacy[i].dutyTime8s ?? 0)
                detailVC.holidayClose = String(pharmacy[i].dutyTime8c ?? 0)
                switch comps.weekday! {
                case 1:
                    detailVC.startTime = pharmacy[i].dutyTime7s
                    detailVC.closeTime = pharmacy[i].dutyTime7c
                case 2:
                    detailVC.startTime = String(pharmacy[i].dutyTime1s!)
                    detailVC.closeTime = String(pharmacy[i].dutyTime1c!)
                case 3:
                    detailVC.startTime = String(pharmacy[i].dutyTime2s!)
                    detailVC.closeTime = String(pharmacy[i].dutyTime2c!)
                case 4:
                    detailVC.startTime = String(pharmacy[i].dutyTime3s!)
                    detailVC.closeTime = String(pharmacy[i].dutyTime3c!)
                case 5:
                    detailVC.startTime = String(pharmacy[i].dutyTime4s!)
                    detailVC.closeTime = String(pharmacy[i].dutyTime4c!)
                case 6:
                    detailVC.startTime = String(pharmacy[i].dutyTime5s!)
                    detailVC.closeTime = String(pharmacy[i].dutyTime5c!)
                case 7:
                    detailVC.startTime = String(pharmacy[i].dutyTime6s!)
                    detailVC.closeTime = String(pharmacy[i].dutyTime6c!)
                default:
                    detailVC.startTime = String(pharmacy[i].dutyTime1s!)
                    detailVC.closeTime = String(pharmacy[i].dutyTime1c!)
                    
                }
                
            }
            
        }
        
        navBarOnModal.modalPresentationStyle = .overCurrentContext
        navBarOnModal.view.backgroundColor = UIColor.clear
        navBarOnModal.navigationBar.barTintColor = UIColor(displayP3Red: 195/255, green: 225/255, blue: 249/255, alpha: 1)
        self.present(navBarOnModal, animated: false, completion: nil)
        //        self.navigationController?.pushViewController(detailVC, animated: true)
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
        searchBar.resignFirstResponder()
        
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(searchBar.text!) {
            (placemarks:[CLPlacemark]?, error:Error?) in
            if error == nil {
                let placemark = placemarks?.first
                let anno = MKPointAnnotation()
                anno.coordinate = (placemark?.location?.coordinate)!
                
                let span = MKCoordinateSpan(latitudeDelta: 0.03,longitudeDelta: 0.03)
                let region = MKCoordinateRegion(center: anno.coordinate, span: span)
                
                self.myMap.setRegion(region, animated: true)
            } else {
                print(error?.localizedDescription ?? "error")
            }
            
            
        }
        
        searchPharmacy(name: searchName)
        _ = searchBar.resignFirstResponder()
        
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = ""
        endTyping = false
        guard let newCoords = locationManager.location?.coordinate else {return}
        
        let region = MKCoordinateRegion(center: newCoords, latitudinalMeters: 500, longitudinalMeters: 500)
        myMap.setRegion(region, animated: true)

        _ = searchBar.resignFirstResponder()
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
    
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //        if segue.identifier == "pharmacyDetails" {
    //            var dest = segue.destination as! PharmacyDetailsViewController
    //            //dest.book =
    //        }
    //    }
}

