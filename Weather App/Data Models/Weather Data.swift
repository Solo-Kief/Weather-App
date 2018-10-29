//  Weather Data.swift
//  Weather App
//
//  Created by Solomon Kieffer on 10/26/18.
//  Copyright © 2018 Phoenix Development. All rights reserved.

import Foundation
import SwiftyJSON
import Alamofire

class WeatherData {
    //MARK:- Types
    enum weatherCondition: String {
        case Day = "clear-day"
        case Night = "clear-night"
        case Rain = "rain"
        case Snow = "snow"
        case Sleet = "sleet"
        case Wind = "wind"
        case Fog = "fog"
        case Cloudy = "cloudy"
        case Partly_Cloudy_Day = "partly-cloudy-day"
        case Partly_Cloudy_Night = "partly-cloudy-night"
        
        var icon: String {
            switch self {
            case .Day:
                return "☀️"
            case .Night:
                return "🌑"
            case .Rain:
                return "🌧"
            case .Snow:
                return "❄️"
            case .Sleet:
                return "❄️"
            case .Wind:
                return "💨"
            case .Fog:
                return "🌫"
            case .Cloudy:
                return "☁️"
            case .Partly_Cloudy_Day:
                return "⛅️"
            case .Partly_Cloudy_Night:
                return "🌑☁️"
            }
        }
    }
    
    //MARK:- Properties
    let temperature: Double
    let highTemperature: Double
    let lowTemperature: Double
    let condition: weatherCondition
    let summary: String?
    
    //MARK:- Initializers
    init(temperature: Double, highTemperature: Double, lowTemperature: Double, condition: weatherCondition) {
        self.temperature = temperature
        self.highTemperature = highTemperature
        self.lowTemperature = lowTemperature
        self.condition = condition
        self.summary = nil
    }
    
    init(temperature: Double, highTemperature: Double, lowTemperature: Double, condition: weatherCondition, summary: String) {
        self.temperature = temperature
        self.highTemperature = highTemperature
        self.lowTemperature = lowTemperature
        self.condition = condition
        self.summary = summary
    }
    
    convenience init?(json: JSON) { //Failable convenience initializer
        guard let temperature = json["currently"]["temperature"].double else {return nil}
        guard let highTemperature = json["daily"]["data"][0]["temperatureHigh"].double else {return nil}
        guard let lowTemperature = json["daily"]["data"][0]["temperatureLow"].double else {return nil}
        guard let summary = json["hourly"]["summary"].string else {return nil}
        guard let condition = weatherCondition(rawValue: json["currently"]["icon"].string!) else {return nil}
        
        self.init(temperature: temperature, highTemperature: highTemperature, lowTemperature: lowTemperature, condition: condition, summary: summary)
    }
}
