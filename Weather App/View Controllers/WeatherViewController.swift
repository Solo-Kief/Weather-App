//  ViewController.swift
//  Weather App
//
//  Created by Solomon Kieffer on 10/24/18.
//  Copyright © 2018 Phoenix Development. All rights reserved.

import UIKit
import Alamofire
import SwiftyJSON
import MapKit

class WeatherViewController: UIViewController,CLLocationManagerDelegate {
    @IBOutlet var summaryLabel: UILabel!
    @IBOutlet var iconLabel: UILabel!
    @IBOutlet var currentTempratureLabel: UILabel!
    @IBOutlet var highTemperatureLabel: UILabel!
    @IBOutlet var lowTemperatureLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    
    var displayWeatherData: WeatherData! {
        didSet {
            setupUI(weatherData: displayWeatherData)
        }
    }
    
    var displayGeocodingData: GeocodingData! {
        didSet {
            locationLabel.text = displayGeocodingData.formattedAddress
        }
    }
    
    var GPS = CLLocationManager()
    let apiManager = APIManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDefaultUI()
        
        if CLLocationManager.locationServicesEnabled() {
            GPS.delegate = self
            GPS.desiredAccuracy = kCLLocationAccuracyBest
            if self.GPS.responds(to: (#selector(CLLocationManager.requestAlwaysAuthorization))) {
                GPS.requestAlwaysAuthorization()
            } else {
                GPS.startUpdatingLocation()
            }
        }
        GPS.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        apiManager.getWeather(latitude: (GPS.location?.coordinate.latitude)!, longitude: (GPS.location?.coordinate.latitude)!) { (weatherData, error) in
            self.setupUI(weatherData: weatherData!)
        }
        
        print(GPS.location?.coordinate.latitude)
        print(GPS.location?.coordinate.longitude)
        GPS.stopUpdatingLocation()
    }
    
    func setupDefaultUI() {
        summaryLabel.text = ""
        locationLabel.text = "Location Needed"
        iconLabel.text = "⛈"
        currentTempratureLabel.text = "NaN"
        highTemperatureLabel.text = "-"
        lowTemperatureLabel.text = "-"
    }
    
    func setupUI(weatherData: WeatherData) {
        summaryLabel.text = weatherData.summary
        locationLabel.text = "Not Implemented"
        iconLabel.text = weatherData.condition.icon
        currentTempratureLabel.text = String(Int(weatherData.temperature.rounded())) + "ºF"
        highTemperatureLabel.text = String(Int(weatherData.highTemperature.rounded())) + "ºF"
        lowTemperatureLabel.text = String(Int(weatherData.lowTemperature.rounded())) + "ºF"
    }
    
    @IBAction func unwindToWeatherDisplay(segue: UIStoryboardSegue) {
        
    }
}
