//  ViewController.swift
//  Weather App
//
//  Created by Solomon Kieffer on 10/24/18.
//  Copyright © 2018 Phoenix Development. All rights reserved.

import UIKit
import Alamofire
import SwiftyJSON

class WeatherViewController: UIViewController {
    @IBOutlet var summaryLabel: UILabel!
    @IBOutlet var iconLabel: UILabel!
    @IBOutlet var currentTempratureLabel: UILabel!
    @IBOutlet var highTemperatureLabel: UILabel!
    @IBOutlet var lowTemperatureLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDefaultUI()
        let weatherData = WeatherData(temperature: 95, highTemperature: 108, lowTemperature: 86, condition: .Night)
        setupUI(weatherData: weatherData)
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
        summaryLabel.text = weatherData.summery
        locationLabel.text = "Not Implemented"
        iconLabel.text = weatherData.condition.icon
        currentTempratureLabel.text = String(weatherData.temperature) + " ºF"
        highTemperatureLabel.text = String(weatherData.highTemperature) + " ºF"
        lowTemperatureLabel.text = String(weatherData.lowTemperature) + " ºF"
    }
}
