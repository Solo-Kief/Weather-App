//  Geocoding Data.swift
//  Weather App
//
//  Created by Solomon Kieffer on 10/26/18.
//  Copyright © 2018 Phoenix Development. All rights reserved.

import Foundation
import SwiftyJSON

class GeocodingData {
    //MARK:- Properties
    var formattedAddress: String
    var latitude: Double
    var longitude: Double
    
    //MARK:- Methods
    init(formattedAddress: String, latitude: Double, longitude: Double) {
        self.formattedAddress = formattedAddress
        self.latitude = latitude
        self.longitude = longitude
    }
    
    convenience init?(json: JSON) {
        guard let results = json["results"].array else {return nil}
        guard let formattedAddress = results[0]["formatted_address"].string else {return nil}
        guard let latitude = results[0]["geometry"]["location"]["lat"].double else {return nil}
        guard let longitude = results[0]["geometry"]["location"]["lng"].double else {return nil}
        
        self.init(formattedAddress: formattedAddress, latitude: latitude, longitude: longitude)
    }
}
