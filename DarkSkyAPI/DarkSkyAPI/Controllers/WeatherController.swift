//
//  WeatherController.swift
//  DarkSkyAPI
//
//  Created by Nathanael Youngren on 10/31/19.
//  Copyright © 2019 Nathanael Youngren. All rights reserved.
//

import Foundation
import CoreLocation

enum NetworkingError: Error {
    case noData
    case unableToDecode
}

class WeatherController {
    
    func fetchWeather(location: CLLocation, completion: @escaping (Weather?, Error?) -> Void) {
        
        guard let baseURL = baseURL else {
            // handle error
            return
        }
        
        let lat = location.coordinate.latitude
        let long = location.coordinate.longitude
        
        let url = baseURL
            .appendingPathComponent(key)
            .appendingPathComponent("\(lat),\(long)")
        
        let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print(error)
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                completion(nil, NetworkingError.noData)
                return
            }
            
            do {
                let weatherResponse = try JSONDecoder().decode(WeatherResponse.self, from: data)
                let weather = weatherResponse.daily
                completion(weather, nil)
            } catch {
                completion(nil, NetworkingError.unableToDecode)
            }
        }
        
        task.resume()
    }
    
    let key = "dca9984943dd9e4cef6f0ef5803c414d"
    let baseURL = URL(string: "https://api.darksky.net/forecast/")
}
