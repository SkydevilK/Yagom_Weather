//
//  Weather.swift
//  Yagom_Weather
//
//  Created by SkydevilK on 2022/01/30.
//

import Foundation

struct Weather {
    var cityName: String = ""
    private var weatherIcon: String = ""
    var weatherIconURL: String {
        get {
            return weatherIcon
        }
        set(value) {
            weatherIcon = "http://openweathermap.org/img/wn/\(value)@2x.png"
        }
    }
    var currentTemperature: String = ""
    var sensoryTemperature: String = ""
    var minimumTemperature: String = ""
    var highestTemperature: String = ""
    var currentHumidity: String = ""
    var atmosphericPressure: String = ""
    var windSpeed: String = ""
    var description: String = ""
}
