//
//  BaseGPSVC.swift
//  KisanAppIos
//
//  Created by Musharib on 25/03/19.
//  Copyright © 2019 Innobles. All rights reserved.
//

import UIKit
import CoreLocation

class BaseGPSVC: BaseVC {
     var locationManager: CLLocationManager!
    var location:CLLocationCoordinate2D!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

}

extension BaseGPSVC : CLLocationManagerDelegate {
    
    func getLocation() {
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
            //locationManager.startUpdatingHeading()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let currentLocation = locations.last {
            location = currentLocation.coordinate
            //print("Current location: \(currentLocation.coordinate)")
            locationManager.stopUpdatingLocation()
        }
    }
    
    
    func getLat() -> String {
        if location != nil
        {
        return String.isNilOrEmptyWithText(string: String(location.latitude))
        }else{
            return ""
        }
    }
    func getLng() -> String {
        if location != nil
        {
            return String.isNilOrEmptyWithText(string: String(location.longitude))
        }else{
            return ""
        }
    }
    
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        print(error)
         self.checkLocation()
        showToast(message: "Location Unavailable", seconds: 2.0)
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        switch status {
        case .notDetermined:
            // If status has not yet been determied, ask for authorization
            manager.requestWhenInUseAuthorization()
            return
            
        case .denied, .restricted:
            showLocationDisabledPopUp()
            
            
            return
        case .authorizedAlways, .authorizedWhenInUse:
            checkLocation()
            break
        @unknown default:
            checkLocation()
            break
           
        }
        manager.delegate = self
        manager.startUpdatingLocation()
        
        
    }
    
    
    
    func checkLocation() {
        if Reachability.isLocationServiceEnabled() == false  {
            self.showLocationDisabledPopUp()
        }
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
    
    
    
    
    
}

