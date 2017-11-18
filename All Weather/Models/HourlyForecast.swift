//
//  HourlyForecast.swift
//  All Weather
//
//  Created by Michal Lučanský on 29.10.17.
//  Copyright © 2017 Lucansky.Michal. All rights reserved.
//

import Foundation
import ObjectMapper

class HourlyForeast: Mappable {
    
    required init?(map: Map) {}
    
    var hourlyForecasts: [HourlyForecast]?
    
    func mapping(map: Map) {
        hourlyForecasts <- map["hourly_forecast"]
    }  
}

class HourlyForecast: Mappable {
    
    required init?(map: Map) {}
    
    var hour: String?
    var temp: String?
    var weatherTypeIcon: String?
    func mapping(map: Map) {
        hour <- map["FCTTIME.hour"]
        temp <- map["temp.metric"]
        weatherTypeIcon <- map["icon"]
    }
}
