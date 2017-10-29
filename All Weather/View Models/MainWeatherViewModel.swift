//
//  MainWeatherViewModel.swift
//  All Weather
//
//  Created by Michal Lučanský on 7.10.17.
//  Copyright © 2017 Lucansky.Michal. All rights reserved.
//

import Foundation
import ReactiveSwift
import CoreLocation

class MainWeatherViewModel {
    
    var userPosition: String? {
        didSet {
            getForecast()
        }
    }
    var currentDate = MutableProperty<String?>(nil)
    var currentWeather = MutableProperty<CurrentWeather?>(nil)
    var hourlyForecasts: HourlyForeast?
    var status = MutableProperty<Bool>(false)
    var error = MutableProperty<String?>(nil)
    
    func getCurrentDate() {   
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        dateFormatter.dateStyle = .full
        currentDate.value = dateFormatter.string(from: date)
    }
    
    func getForecast() {
        
        guard let location = self.userPosition else { return }
        NetworkRequests.forecastRequest(endPoint: .actualWeather, location: location) { (weather, error) in
            if let error = error {
                self.error.value = error.localizedDescription
            } else if let weeather = weather {
                self.currentWeather.value = weeather
                
            }
        }
    }
    
    func getHourlyForecasts() {
        guard let location = self.userPosition else { return }
        NetworkRequests.hourlyForecast(endPoint: .hourlyWeatherForecast, location: location) { (hourlyForecasts, error) in
            if let error = error {
                self.error.value = error.localizedDescription
            } else if let forecasts = hourlyForecasts {
                self.hourlyForecasts = forecasts
                self.status.value = true
            }
        }
    }
}
