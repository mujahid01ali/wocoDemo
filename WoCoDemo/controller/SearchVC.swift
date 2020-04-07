//
//  ViewController.swift
//  WoCoDemo
//
//  Created by Mujahid on 26/02/20.
//  Copyright © 2020 Mujahid. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation

class SearchVC: BaseVC, UITableViewDataSource, UISearchBarDelegate,SearchLocationCellDelegate,CLLocationManagerDelegate {
    @IBOutlet weak var lbCurrentTime: UILabel!
    @IBOutlet weak var lbLocation: UILabel!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var locationView: UIView!
    @IBOutlet weak var mainStackView: UIStackView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var checkinView: UIView!
    @IBOutlet weak var lbCheckinTime: UILabel!
    @IBOutlet weak var viewCheckout: UIView!
    var recentVisit = RecentVisitResponse()
    var visitData = Datum()
    
    //  var data = [Datum]()
    var data = [Datum]()
    
    
    var filteredData: [Datum]!
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkinView.isHidden = true
        searchView.isHidden = false
        
        viewCheckout.roundCorners([.allCorners], radius: 16.0)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapFunction))
        viewCheckout.isUserInteractionEnabled = true
        viewCheckout.addGestureRecognizer(tap)
        
        callApi()
        navigationItem.title = "Manual Check In"
        
        
        // mainStackView.roundCorners([.allCorners], radius: 8.0)
        checkinView.roundCorners(.allCorners, radius: 8.0)
        searchView.roundCorners(.allCorners, radius: 8.0)
        locationView.roundCorners([.bottomRight,.topRight], radius: 16.0)
        isAuthorizedtoGetUserLocation()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
        
    }
    
    @objc
    func tapFunction(sender:UITapGestureRecognizer) {
        searchView.isHidden = false
        checkinView.isHidden = true
    }
    
    func setupTable()  {
        tableView.registerCellNib(SearchLocationCell.self)
        tableView.dataSource = self
        searchBar.delegate = self
        tableView.reloadData()
        
        
    }
    
    func showLocationDisabledPopUp() {
        let alertController = UIAlertController(title: "Background Location Access Disabled",
                                                message: (Bundle.main.object(forInfoDictionaryKey: "NSLocationAlwaysUsageDescription") as! String),
                                                preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        let openAction = UIAlertAction(title: "Open Settings", style: .default) { (action) in
            
            //            if let url  = URL(string: "App-prefs:root=LOCATION_SERVICES") {
            //                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            //            }
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        alertController.addAction(openAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func onCheckin(response:Datum){
        visitData = response
        searchView.isHidden = true
        checkinView.isHidden = false
        
        lbName.text = "Hi Admin"
        lbLocation.attributedText =  attributedStringConvert(str1: "You are currently at ", str2: response.title, colorStr1: "#000000", colorStr2: "#0077b3")
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if filteredData != nil && !filteredData.isEmpty && filteredData.count > 0{
            return filteredData.count
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchLocationCell", for: indexPath) as! SearchLocationCell
        cell.setData(response: filteredData![indexPath.row])
        cell.delegate = self
        //  cell.lbLocation?.text = filteredData[indexPath.row]
        return cell
    }
    
    func callApi() {
        let url = "http://dev.woco.co.in/api-v1/recent-visited"
        let headers: HTTPHeaders = [
            "AccessToken": "ODhLTDdKNDdBMlZURDE4WUlFMDZZOTJMVVZDN1RYQ042Q0haV0g5NlNKQjY1SkpBMVRVVFZTQk0zR1pHMjUwQw",
            "Accept": "application/json"
        ]
        
        setParam(url: url, headers: headers, className: RecentVisitResponse.self)
        //setParamPost(url: url2, headers: [:], param: param as! [String : Any], className: LoginResponse.self)
        
    }
    
    override func onSuccessResponse(response: Any) {
        recentVisit = RecentVisitResponse()
        recentVisit = response as! RecentVisitResponse
        if recentVisit.status == 200 {
            filteredData = recentVisit.data
            data = filteredData
        }else{
            if recentVisit.message != nil && !recentVisit.message.isEmpty{
                showToast(message: recentVisit.message)
            }
        }
        
        setupTable()
        
    }
    override func onFailResponse(response: Error) {
        showToast(message: response.localizedDescription)
    }
    
    
    
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let searchText = searchBar.text?.lowercased() {
            if searchText.count == 0 {
                filteredData = data
            }
            else {
                filteredData = data.filter {
                    return $0.title.lowercased().contains(searchText)
                }
            }
        }
        tableView.reloadData()
    }
}
extension SearchVC {
    func onClick(visitData: Datum) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CheckInInitiateVC") as! CheckInInitiateVC
        vc.vistData = visitData
        vc.modalPresentationStyle = .overCurrentContext
        vc.view.backgroundColor = UIColor(hexString: "#000000", alpha: 0.7)
        vc.view.roundCorners([.allCorners], radius: 8.0)
        vc.vc = self
        self.present(vc, animated: false, completion: nil)
    }
}

extension SearchVC{
    func isAuthorizedtoGetUserLocation() {
        
        if CLLocationManager.authorizationStatus() != .authorizedWhenInUse     {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            print("User allowed us to access location")
            //do whatever init activities here.
            locationManager.requestWhenInUseAuthorization()
            
        }else if status == .denied || status == .restricted{
            showLocationDisabledPopUp()
            
        }else if status == .notDetermined{
            isAuthorizedtoGetUserLocation()
            
        }else if status == .authorizedAlways{
            locationManager.requestAlwaysAuthorization()
            
        }
        locationManager.startUpdatingLocation()
        
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        UserDefaults.standard.set(String(locValue.latitude), forKey: Constant.LAT)
        UserDefaults.standard.set(String(locValue.longitude), forKey: Constant.LNG)
        locationManager.stopUpdatingLocation()
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error \(error)")
    }
}




