//
//  WeatherTableViewController.swift
//  DarkSkyAPI
//
//  Created by Nathanael Youngren on 10/31/19.
//  Copyright © 2019 Nathanael Youngren. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = view.bounds.height
        checkLocationPermission()
    }
    
    private func fetchWeather(location: CLLocation) {
        locationManager.stopUpdatingLocation()
        weatherController.fetchWeather(location: location) { (weather, error) in
            
            if let error = error {
                // handle error
                print(error)
                return
            }
            
            if let weather = weather {
                self.weather = weather
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    @IBAction func refreshButtonWasTapped(_ sender: UIBarButtonItem) {
        checkLocationPermission()
    }
    
    private func checkLocationPermission() {
        if CLLocationManager.locationServicesEnabled() {
            setUpLocationManager()
            requestLocationPermission()
        } else {
            let locationServicesAlert = UIAlertController(title: "Location Services Disabled", message: "Please update your settings to allow location services in DarkSky.", preferredStyle: .alert)
            let dismiss = UIAlertAction(title: "Okay", style: .default, handler: nil)
            locationServicesAlert.addAction(dismiss)
            present(locationServicesAlert, animated: true, completion: nil)
        }
    }
    
    private func setUpLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    private func requestLocationPermission() {
        
        let dismiss = UIAlertAction(title: "Okay", style: .default, handler: nil)
        
        switch CLLocationManager.authorizationStatus() {
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        case .denied:
            let deniedAlert = UIAlertController(title: "Location Access Denied", message: "No data can be retrieved because access to your location was denied.", preferredStyle: .alert)
            deniedAlert.addAction(dismiss)
            self.present(deniedAlert, animated: true, completion: nil)
            
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()

        case .restricted:
            let restrictedAlert = UIAlertController(title: "Location Access Restricted", message: "No data can be retrieved because access to your location is restricted.", preferredStyle: .alert)
            restrictedAlert.addAction(dismiss)
            self.present(restrictedAlert, animated: true, completion: nil)
            
        default:
            let unknownAlert = UIAlertController(title: "Location Access Not Found", message: "No data can be retrieved at this time.", preferredStyle: .alert)
            unknownAlert.addAction(dismiss)
            self.present(unknownAlert, animated: true, completion: nil)
        }
    }
    

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath)
        guard let weatherCell = cell as? WeatherTableViewCell, let weather = weather else { return cell }
        
        let temp = weather.temperature[0]
        
        let date = Date(timeIntervalSinceNow: temp.time)
        let dayString = date.day()
        
        weatherCell.iconImageView.image = UIImage(named: weather.icon)
        weatherCell.currentTempLabel.text = String(temp.current)
        weatherCell.todaysForecastLabel.text = "\(dayString) H:\(temp.high) L:\(temp.low)"
        
        return weatherCell
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ShowWeatherDetail" {
            
            guard let detailVC = segue.destination as? DetailViewController else {
                fatalError("Could not unwrap DetailViewController.")
            }
            
            guard let weather = weather else {
                let noWeatherAlert = UIAlertController(title: "No Weather Data", message: "No weather data was found.", preferredStyle: .alert)
                present(noWeatherAlert, animated: true, completion: nil)
                return
            }
            
            detailVC.weather = weather
        }
    }
    
    let locationManager = CLLocationManager()
    var weather: Weather?
    let weatherController = WeatherController()
}

extension WeatherTableViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        fetchWeather(location: location)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationPermission()
    }
}

extension Date {
    func day() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd"
        formatter.dateStyle = .medium
        return formatter.string(from: self)
    }
}
