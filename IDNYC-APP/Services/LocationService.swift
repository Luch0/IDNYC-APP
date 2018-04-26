//
//  LocationService.swift
//  IDNYC-APP
//
//  Created by Luis Calle on 4/24/18.
//  Copyright © 2018 Lucho. All rights reserved.
//

import Foundation
import CoreLocation

protocol LocationServiceDelegate: class {
    func updateLocation(with lat: Double, and long: Double)
}

class LocationService: NSObject {
    
    private override init() {
        super.init()
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
    }
    static let manager = LocationService()
    
    weak var delegate: LocationServiceDelegate?
    
    private var locationManager: CLLocationManager!
    
    var latitude: Double!
    var longitude: Double!
    
}

extension LocationService {
    
    public func checkForLocationServices() -> CLAuthorizationStatus {
        var status: CLAuthorizationStatus!
        
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined:
                print("Not Determined")
                locationManager.requestWhenInUseAuthorization()
            case .denied:
                print("Denied")
            case .authorizedAlways:
                print("Authorized Always")
            case .authorizedWhenInUse:
                print("Authorized When in Use")
                
            default:
                break
            }
        } else { // update UI to inform user
            print("Go to settings to update your location permission")
        }
        status = CLLocationManager.authorizationStatus()
        return status
    }
    
}

extension LocationService: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        latitude = locations.last?.coordinate.latitude
        longitude = locations.last?.coordinate.longitude
        
        delegate?.updateLocation(with: latitude, and: longitude)
        
        locationManager.stopUpdatingLocation()
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location Manager: didFailWithError - \(error.localizedDescription)")
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("Location Manager: didChangeAuthorization - \(status)")
    }
    
    func getCurrentLatitude() -> Double? {
        return latitude
    }
    
    func getCurrentLongitude() -> Double? {
        return longitude
    }
    
}
