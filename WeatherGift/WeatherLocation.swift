//
//  WeatherLocation.swift
//  WeatherGift
//
//  Created by CSOM on 4/2/17.
//  Copyright © 2017 CSOM. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class WeatherLocation {
    var name = ""
    var coordinates = ""
    var currentTemp = -999.9
    var dailySummary = ""
    //class wide scope

    func getWeather(completed: @escaping() ->()) {
        
        let weatherURL = urlBase + urlAPIKey + coordinates
        print(weatherURL)
        
        Alamofire.request(weatherURL).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                if let temperature = json["currently"]["temperature"].double {
                    print("temp inside getWeather = \(temperature)")
                    self.currentTemp = temperature
                } else {
                    print("could not return temperature")
                }
                if let summary = json["daily"]["summary"].string {
                    print("SUMMARY inside getWeather = \(summary)")
                    self.dailySummary = summary
                } else {
                    print("could not return summary")
                }
            case .failure(let error):
                print(error)
            }
            completed()
        }
    }
}
