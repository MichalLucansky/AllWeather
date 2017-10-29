//
//  EndPoint.swift
//  All Weather
//
//  Created by Michal Lučanský on 7.10.17.
//  Copyright © 2017 Lucansky.Michal. All rights reserved.
//

import Alamofire

enum ApiEndPoint {
    
    static let baseURL = "http://api.wunderground.com/api/"
    static let apiKey = "3f886feda3e980c2"
    static let format = ".json"
    
    case actualWeather
    case weatherForcastForThreeDays
    case weatherForcastFotTenDays
    case hourlyWeatherForecast
  
    var forecastType: String {
        switch self {
        case .actualWeather:
            return "/forecast/conditions/lang:SK/q/"
        case .weatherForcastForThreeDays:
            return "/forecast/lang:SK/q/"
        case .weatherForcastFotTenDays:
            return "/forecast10day/lang:SK/q/"
        case .hourlyWeatherForecast:
            return "/hourly/lang:SK/q/"
            
        }
    }
    
    func forecastURL(location: String) -> String {
        return ApiEndPoint.baseURL + ApiEndPoint.apiKey + forecastType + location + ApiEndPoint.format
    }
}
