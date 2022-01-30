//
//  Value.swift
//  Yagom_Weather
//
//  Created by SkydevilK on 2022/01/31.
//

import Foundation
class Value {
    static let shared = Value()
    private init() {
        let decoder = JSONDecoder()
        guard let jsonData = loadJson() else {
            return
        }
        if let json = try? decoder.decode([City].self, from: jsonData) {
            cities = json
        }
    }
    private var cities: [City] = []
    
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
        for city in cities {
            if city.name == name {
                return city
            }
        }
        return City()
    }
    
}
