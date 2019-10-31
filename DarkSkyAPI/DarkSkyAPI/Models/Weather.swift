//
//  Weather.swift
//  DarkSkyAPI
//
//  Created by Nathanael Youngren on 10/31/19.
//  Copyright © 2019 Nathanael Youngren. All rights reserved.
//

import Foundation

struct WeatherResponse: Codable {
    let daily: Weather
    let currently: Currently
}

struct Currently: Codable {
    let temperature: Double
}

struct Weather: Codable {
    let summary: String
    let icon: String
    var temperature: [Temperature]
    
    enum WeatherKeys: String, CodingKey {
        case summary, icon, temperature = "data"
    }

    init(from decoder: Decoder) throws {

        let weatherContainer = try decoder.container(keyedBy: WeatherKeys.self)

        summary = try weatherContainer.decode(String.self, forKey: .summary)
        icon = try weatherContainer.decode(String.self, forKey: .icon)
        temperature = try weatherContainer.decode([Temperature].self, forKey: .temperature)
    }
}

struct Temperature: Codable {
    var time: TimeInterval
    var high: Double
    var low: Double
    
    var current: Double = 0.0
    
    enum TemperatureKeys: String, CodingKey {
         case time, high = "temperatureHigh", low = "temperatureLow"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: TemperatureKeys.self)
        
        let integerTime = try container.decode(Int.self, forKey: .time)
        time = Double(integerTime)
        
        high = try container.decode(Double.self, forKey: .high)
        low = try container.decode(Double.self, forKey: .low)
    }
}
