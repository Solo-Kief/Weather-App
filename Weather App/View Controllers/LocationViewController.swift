//  LocationViewController.swift
//  Weather App
//
//  Created by Solomon Kieffer on 10/26/18.
//  Copyright © 2018 Phoenix Development. All rights reserved.

import UIKit

class LocationViewController: UIViewController, UISearchBarDelegate {
    @IBOutlet var searchBar: UISearchBar!
    static var isLocationOverriden = false
    static var overridenLocation = ""
    
    var geocodingData: GeocodingData?
    var weatherData: WeatherData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchAddress = searchBar.text?.replacingOccurrences(of: " ", with: "+") else {return}
        recieveGeocodingData(searchAddress: searchAddress)
    }
    
    func recieveGeocodingData(searchAddress: String) {
        if searchAddress.lowercased() != "local" {
            APIManager().geocode(address: searchAddress) { (geocodingData, error) in
                if let recievedError = error {
                    print(recievedError.localizedDescription)
                    return
                }
                if let geoData = geocodingData {
                    self.geocodingData = geoData
                    self.retrieveWeatherData(latitude: (geocodingData?.latitude)!, longitude: (geocodingData?.longitude)!)
                }
            }
        } else {
            LocationViewController.isLocationOverriden = false
            LocationViewController.overridenLocation = ""
        }
    }
    
    func retrieveWeatherData(latitude: Double, longitude: Double) {
        APIManager().getWeather(latitude: latitude, longitude: longitude) { (weatherData, error) in
            if let recievedError = error {
                print(recievedError.localizedDescription)
                return
            }
            if let data = weatherData {
                self.weatherData = data
                self.performSegue(withIdentifier: "unwindToWeatherDisplay", sender: self)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? WeatherViewController, let retrievedGeocodingData = geocodingData, let retrievedWeatherData = weatherData {
            destination.displayWeatherData = retrievedWeatherData
            destination.displayGeocodingData = retrievedGeocodingData
        }
    }
}
