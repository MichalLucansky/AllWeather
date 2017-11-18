//
//  NetworkRequests.swift
//  All Weather
//
//  Created by Michal Lučanský on 7.10.17.
//  Copyright © 2017 Lucansky.Michal. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class NetworkRequests {

    static func forecastRequest(endPoint: ApiEndPoint, location: String, completion: @escaping (CurrentWeather?, Error? ) -> Void) {
        guard let url = URL(string: endPoint.forecastURL(location: location)) else {return}
        print("------------------>predpoved\(url)")
        Alamofire.request(url).responseObject { (response: DataResponse<CurrentWeather>) in
            if let error = response.result.error {
                completion(nil, error)
            } else {
            let weatherResponse = response.result.value
                print(weatherResponse?.icon)
            completion(weatherResponse, nil)
            }
        }
    }
    
    static func hourlyForecast(endPoint: ApiEndPoint, location: String, completion: @escaping (HourlyForeast?, Error? ) -> Void) {
         guard let url = URL(string: endPoint.forecastURL(location: location)) else {return}
        print("------------------>\(url)")
        Alamofire.request(url).responseObject { (response: DataResponse<HourlyForeast>) in
            if let error = response.result.error {
                completion(nil, error)
            } else {
                let forecastResponse = response.result.value
                completion(forecastResponse, nil)
            }
        }

    }
}
