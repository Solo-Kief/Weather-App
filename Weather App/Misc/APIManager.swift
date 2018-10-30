//  APIManager.swift
//  Weather App
//
//  Created by Solomon Kieffer on 10/29/18.
//  Copyright © 2018 Phoenix Development. All rights reserved.

import Foundation
import Alamofire
import SwiftyJSON

class APIManager {
    private let darkSkyKey = "3cefbd324e1163f2774db3b98731fe84"
    private let googleKey = "AIzaSyCPTI9AQ-ApTK4KdHZv-H69URe2_-nFPzQ" //"AIzaSyCCCayiW61w7akxjIQHAvXJb5bLRgZXpJ0"
    private let darkSkyURL = "https://api.darksky.net/forecast/"
    private let googleURL = "https://maps.googleapis.com/maps/api/geocode/json?address="
    
    enum APIErrors: Error {
        case noData
        case noResponse
        case invalidData
    }
    
    func getWeather(latitude: Double, longitude: Double, onCompletion: @escaping (WeatherData?, Error?) -> Void) {
        let url = darkSkyURL + darkSkyKey + "/" + String(latitude) + "," + String(longitude)
        
        let request = Alamofire.request(url)
        
        request.responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                if let weatherData = WeatherData(json: json) {
                    onCompletion(weatherData, nil)
                } else {
                    onCompletion(nil, APIErrors.invalidData)
                }
            case .failure(let error):
                onCompletion(nil, error)
            }
        }
    }

    func geocode(address: String, onCompletion: @escaping (GeocodingData?, Error?) -> Void) {
        let url = googleURL + address + "&key=" + googleKey
        
        let request = Alamofire.request(url)
        
        request.responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                if let geocodingData = GeocodingData(json: json) {
                    onCompletion(geocodingData, nil)
                } else {
                    onCompletion(nil, APIErrors.invalidData)
                }
            case .failure(let error):
                onCompletion(nil, error)
            }
        }
    }
}
