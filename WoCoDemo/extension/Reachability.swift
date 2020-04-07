//
//  Reachability.swift
//  KisanAppIos
//
//  Created by Musharib on 25/03/19.
//  Copyright © 2019 Innobles. All rights reserved.
//


import CoreLocation

open class Reachability {
    class func isLocationServiceEnabled() -> Bool {
        if CLLocationManager.locationServicesEnabled() {
            switch(CLLocationManager.authorizationStatus()) {
            case .notDetermined, .restricted, .denied:
                return false
            case .authorizedAlways, .authorizedWhenInUse:
                return true
            default:
                print("Something wrong with Location services")
                return false
            }
        } else {
            print("Location services are not enabled")
            return false
        }
    }
}
