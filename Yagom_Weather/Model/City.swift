//
//  city.swift
//  Yagom_Weather
//
//  Created by SkydevilK on 2022/01/30.
//

import Foundation

struct City: Codable {
    var id: Int = 0
    var name: String = ""
    var state: String? = nil
    var country: String = ""
    var coord = Coord()
}

struct Coord: Codable {
    var lon: Double = 0
    var lat: Double = 0
}
