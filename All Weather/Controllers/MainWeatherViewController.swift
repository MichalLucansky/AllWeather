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
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var actualTempLabel: UILabel!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var hourForecast: UICollectionView!
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
        viewModel.status.producer.startWithValues { (value) in
            self.hourForecast.reloadData()
        }
        
        viewModel.currentDate.producer.startWithValues { [weak self] (date) in
            self?.dateLabel.text = date
        }
        viewModel.currentWeather.producer.startWithValues({ [weak self](weather) in
            self?.cityNameLabel.text = weather?.nameLocation
            guard let temp = weather?.currentTemp, let minTemp = weather?.minTemp, var maxTemp = weather?.maxTemp else { return }
            if temp > Double(maxTemp)! {
                maxTemp = "\(Int(temp))"
            }
            self?.actualTempLabel.text = "\(temp)°"
            self?.maxTempLabel.text = maxTemp + "°"
            self?.minTempLabel.text = minTemp + "°"
        })
        viewModel.error.producer.startWithValues({ [weak self] (error) in
            print(error)
        })
        
    }
    
    private func locationHendler() {
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
        viewModel.userPosition = "\(lat),\(long)"
        print("\(lat),\(long)")
        viewModel.getForecast()
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationPicker()
    }
    
}

extension MainWeatherViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 24
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = hourForecast.dequeueReusableCell(withReuseIdentifier: "hourForecast", for: indexPath) as? HourlyForecastCell
        guard let temp = viewModel.hourlyForecasts?.hourlyForecasts![indexPath.row].temp, let hour = viewModel.hourlyForecasts?.hourlyForecasts![indexPath.row].hour, let iconURL = viewModel.hourlyForecasts?.hourlyForecasts![indexPath.row].weatherTypeIcon  else {
            return cell!
        }
        cell?.setUpUi(temp: temp, hours: hour, weatherIconURL: iconURL)
        
        return cell ?? UICollectionViewCell()
    }
    
}
