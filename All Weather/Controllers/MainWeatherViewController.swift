//
//  ViewController.swift
//  All Weather
//
//  Created by Michal Lučanský on 23.9.17.
//  Copyright © 2017 Lucansky.Michal. All rights reserved.
//

import UIKit
import CoreLocation
import ReactiveSwift
import ReactiveCocoa

class MainWeatherViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var elevationLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var actualTempLabel: UILabel!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var hourForecast: UICollectionView!
    @IBOutlet weak var actualWeatherIcon: UIImageView!
    var viewModel: MainWeatherViewModel!
    var manager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = MainWeatherViewModel()
        bindModel()
        viewModel.getCurrentDate()
        locationHendler()
        viewModel.getForecast()
        viewModel.getHourlyForecasts()
        tabBarController?.tabBar.backgroundImage = UIImage()
        tabBarController?.tabBar.shadowImage = UIImage()
        hourForecast.delegate = self
        hourForecast.dataSource = self
        
    }
    
    func bindModel() {
        viewModel.status.producer.startWithValues { (_) in
            self.hourForecast.reloadData()
        }
        
        viewModel.currentDate.producer.startWithValues { [weak self] (date) in
            self?.dateLabel.text = date
        }
        viewModel.currentWeather.producer.startWithValues({ [weak self](weather) in
            guard let temp = weather?.currentTemp, let minTemp = weather?.minTemp, var maxTemp = weather?.maxTemp, let icon = weather?.icon, let elevation = weather?.elevation
                else { return }
            if temp > Double(maxTemp)! {
                maxTemp = "\(Int(temp))"
            }
            self?.actualTempLabel.text = "\(temp)°"
            self?.maxTempLabel.text = maxTemp + "°"
            self?.minTempLabel.text = minTemp + "°"
            self?.actualWeatherIcon.image = self?.viewModel.setCurrentWeatherType(weather: icon)
            self?.elevationLabel.text = elevation
        })
        viewModel.error.producer.startWithValues({ [weak self] (error) in
            print(error)
        })
        
    }
    
     func locationHendler() {
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.desiredAccuracy = kCLLocationAccuracyKilometer
        manager.distanceFilter = kCLLocationAccuracyKilometer
        manager.startMonitoringSignificantLocationChanges()
        locationPicker()
    }
    
    func locationPicker() {
        guard let lat = manager.location?.coordinate.latitude, let long = manager.location?.coordinate.longitude
            else {return}
        let geoCoder = CLGeocoder()
        let currentlocation = CLLocation(latitude: lat, longitude: long)
        geoCoder.reverseGeocodeLocation(currentlocation) { [weak self](placemark, error) in
            if error != nil {
            }
            let actualPlace = placemark
            
            if (actualPlace?.count)! > 0 {
                let pm = actualPlace?[0]
                guard let city = pm?.locality else { return }
                self?.cityNameLabel.text = city
            }
        }
        viewModel.userPosition = "\(lat),\(long)"
        viewModel.getForecast()
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationPicker()

    }
  
}

extension MainWeatherViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 24 //viewModel.hourlyForecasts?.hourlyForecasts?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = hourForecast.dequeueReusableCell(withReuseIdentifier: "hourForecast", for: indexPath) as? HourlyForecastCell
        guard let temp = viewModel.hourlyForecasts?.hourlyForecasts![indexPath.row].temp,
            let hour = viewModel.hourlyForecasts?.hourlyForecasts![indexPath.row].hour,
            let icon = viewModel.hourlyForecasts?.hourlyForecasts![indexPath.row].weatherTypeIcon
        
        else { return cell! }
        let iconImage = viewModel.setCurrentWeatherType(weather: icon)
        cell?.setUpUi(temp: temp, hours: hour, weatherIconURL: iconImage)
        
        return cell ?? UICollectionViewCell()
    }
    
}
