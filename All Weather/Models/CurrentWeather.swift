//
//  CurrentWeather.swift
//  All Weather
//
//  Created by Michal Lučanský on 7.10.17.
//  Copyright © 2017 Lucansky.Michal. All rights reserved.
//

import Foundation
import ObjectMapper

class CurrentWeather: Mappable {

    required init?(map: Map) {}
    
    var nameLocation: String?
    var stateLocatio: String?
    var currentTemp: Double?
    var minTemp: String?
    var maxTemp: String?
    
    func mapping(map: Map) {
        
        nameLocation <- map["current_observation.display_location.city"]
        stateLocatio <- map["current_observation.display_location.country_iso3166"]
        currentTemp <- map["current_observation.temp_c"]
        minTemp <- map["forecast.simpleforecast.forecastday.0.low.celsius"]
        maxTemp <- map["forecast.simpleforecast.forecastday.0.high.celsius"]
    }
    
}
