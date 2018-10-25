//  ViewController.swift
//  Weather App
//
//  Created by Solomon Kieffer on 10/24/18.
//  Copyright © 2018 Phoenix Development. All rights reserved.

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {
    @IBOutlet var summaryLabel: UILabel!
    @IBOutlet var weatherIconLabel: UILabel!
    @IBOutlet var currentTempratureLabel: UILabel!
    @IBOutlet var highTemperatureLabel: UILabel!
    @IBOutlet var lowTemperatureLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ////////////////////////////////////////////////////////////
        let address = "6229 New Glasgow Rd, scottsville, ky"
        
        let googleURL = "https://maps.googleapis.com/maps/api/geocode/json?address=\(address.replacingOccurrences(of: " ", with: "+")),+CA&key=\(APIKeys().googleKey)"
        
        let request1 = Alamofire.request(googleURL)
        
        request1.responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print(json)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        ////////////////////////////////////////////////////////////
        let baseURL = "https://api.darksky.net/forecast/\(APIKeys().darkSkyKey)/"
        let latitude = "37.004842"
        let longitude = "-85.925876"
        
        let callURL = baseURL + latitude + "," + longitude
        
        let request = Alamofire.request(callURL)
        
        request.responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print(json)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        ////////////////////////////////////////////////////////////
    }
}
