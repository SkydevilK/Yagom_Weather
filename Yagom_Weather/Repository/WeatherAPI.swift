//
//  WeatherAPI.swift
//  Yagom_Weather
//
//  Created by SkydevilK on 2022/01/30.
//

import Foundation

class WeatherAPI {
    private var citys: [City] {
        let decoder = JSONDecoder()
        guard let jsonData = loadJson() else {
            return []
        }
        if let json = try? decoder.decode([City].self, from: jsonData) {
            return json
        }
        return []
    }
    
    private func loadJson() -> Data? {
        guard let jsonPath = Bundle.main.url(forResource: "city.list.min", withExtension: "json") else { return nil }
        do {
            let data = try Data(contentsOf: jsonPath)
            return data
        } catch {
            return nil
        }
    }
    
    func getCity(name: String) -> City{
        for city in citys {
            if city.name == name {
                return city
            }
        }
        return City()
    }
    
    func getWeather(city: String, completion: @escaping (Weather) -> ()) {
        if let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?id=\(getCity(name: city).id)&appid=e565bb0935cac72af3e63168941e8b30&lang=kr&units=metric") {
            var request = URLRequest.init(url: url)
            
            request.httpMethod = "GET"
            
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                guard let data = data else {
                    return
                }
                
                // data
                if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String : Any] {
                    var weather = Weather()
                    if let cityName = json["name"] as? String {
                        weather.cityName = cityName
                    }
                    if let w = json["weather"] as? [[String: Any]] {
                        if let icon = w.first?["icon"] as? String {
                            weather.weatherIconURL = icon
                        }
                        if let description = w.first?["description"] as? String {
                            weather.description = description
                        }
                    }
                    if let main = json["main"] as? [String : Any] {
                        if let currentTemperature = main["temp"] as? Double {
                            weather.currentTemperature = String(format: "%.f", currentTemperature)
                        }
                        if let sensoryTemperature = main["feels_like"] as? Double {
                            weather.sensoryTemperature = String(format: "%.f", sensoryTemperature)
                        }
                        if let minimumTemperature = main["temp_min"] as? Double {
                            weather.minimumTemperature = String(format: "%.f", minimumTemperature)
                        }
                        if let highestTemperature = main["temp_max"] as? Double {
                            weather.highestTemperature = String(format: "%.f", highestTemperature)
                        }
                        if let currentHumidity = main["humidity"] as? Double {
                            weather.currentHumidity = String(format: "%.f", currentHumidity)
                        }
                        if let atmosphericPressure = main["pressure"] as? Double {
                            weather.atmosphericPressure = String(format: "%.f", atmosphericPressure)
                        }
                    }
                    if let wind = json["wind"] as? [String : Any] {
                        if let windSpeed = wind["speed"] as? Double {
                            weather.windSpeed = String(format: "%.f", windSpeed)
                        }
                    }
                    completion(weather)
                }
            }.resume()
        }
    }
}
