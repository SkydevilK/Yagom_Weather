//
//  WeatherViewModel.swift
//  Yagom_Weather
//
//  Created by SkydevilK on 2022/01/31.
//

import Foundation

struct SimpleWeatherListViewModel {
    var weathers: [Weather]
}

extension SimpleWeatherListViewModel {
    var numberOfSections: Int {
        return 1
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return self.weathers.count
    }
    
    func weatherAtIndex(_ index: Int) -> SimpleWeatherViewModel {
        let weather = self.weathers[index]
        return SimpleWeatherViewModel(weather)
    }
}

extension SimpleWeatherListViewModel {
    mutating func sortByName() {
        weathers.sort { (left, right) -> Bool in
            return left.cityName < right.cityName
        }
    }
    mutating func sortByTemperature() {
        weathers.sort { (left, right) -> Bool in
            return left.currentTemperature > right.currentTemperature
        }
    }
}
struct SimpleWeatherViewModel {
    private let weather: Weather
}

extension SimpleWeatherViewModel {
    init(_ weather: Weather) {
        self.weather = weather
    }
}

extension SimpleWeatherViewModel {
    var cityName: String? {
        return self.weather.cityName
    }
    var currentTemperature: String? {
        if Value.shared.units == "metric" {
            return "\(NSLocalizedString("currentTemperature", comment: "")) : \(self.weather.currentTemperature)°C"
        } else {
            return "\(NSLocalizedString("currentTemperature", comment: "")) : \(self.weather.currentTemperature)°F"
        }
    }
    var currentHumidity: String? {
        return "\(NSLocalizedString("currentHumidity", comment: "")) : \(self.weather.currentHumidity)%"
    }
    var iconURL: String? {
        return self.weather.weatherIconURL
    }
}

