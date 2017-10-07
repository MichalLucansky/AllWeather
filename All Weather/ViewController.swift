//
//  ViewController.swift
//  All Weather
//
//  Created by Michal Lučanský on 23.9.17.
//  Copyright © 2017 Lucansky.Michal. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    private var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.startMonitoringSignificantLocationChanges()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        guard let lat = location?.coordinate.latitude, let long = location?.coordinate.longitude
            else {return}
        let locationSting = "\(lat),\(long)"
        print(test(urlPath: .actualWeather, location: locationSting))
        print(test(urlPath: .weatherForcastForThreeDays, location: locationSting))
        print(test(urlPath: .weatherForcastFotTenDays, location: locationSting))
    }
    
    func test(urlPath: ApiEndPoint, location: String) -> String {
        return urlPath.myURL(location: location )
    }
}
