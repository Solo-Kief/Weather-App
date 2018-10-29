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
        getUpdate()
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
    
    func getUpdate() {
        let baseURL = "https://api.darksky.net/forecast/"
        let apiKey = APIKeys().darkSkyKey
        let latitude = 37.8267
        let longitude = -122.4233
        let requestURL = "\(baseURL)\(apiKey)/\(latitude),\(longitude)"
        let request = Alamofire.request(requestURL)
        
        request.responseJSON { response in
            switch response.result {
            case .success(let data):
                let json = JSON(data)
                guard let weatherData = WeatherData(json: json) else {return self.setupDefaultUI()}
                self.setupUI(weatherData: weatherData)
            case .failure(let error):
                print(error.localizedDescription)
                self.setupDefaultUI()
            }
        }
    }
}
