//
//  currentWeather.swift
//  Earthquake
//
//  Created by Eugene Liu on 6/7/18.
//  Copyright © 2018 Eugene Liu. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class currentWeather
{
    private var _cityName: String!
    private var _date: String!
    private var _weatherType: String!
    private var _currentTemp: Double!
    
    var cityName: String
    {
        if _cityName == nil
        {
            _cityName = ""
        }
        return _cityName
    }
    
    var weatherType: String
    {
        if _weatherType == nil
        {
            _weatherType = ""
        }
        return _weatherType
    }
    
    var date: String
    {
        if _date == nil
        {
            _date = ""
        }
        return _date
    }
    
    var currentTemp: Double
    {
        if _currentTemp == nil
        {
            _currentTemp = 0.0
        }
        return _currentTemp
    }
    
    func downloadCurrentWeather(completed: @escaping DownloadComplete)
    {
        Alamofire.request(API_URL).responseJSON
            {
                (response) in
                
                let result = response.result
                let json = JSON(result.value)
                let tempDate = json["dt"].double
                let downloadedTemp = json["main"]["temp"].double
                let convertedDate = Date(timeIntervalSince1970: tempDate!)
                let dateFormatter = DateFormatter()
                dateFormatter.dateStyle = .medium
                dateFormatter.timeStyle = .none        //no time only date
                let currentDate = dateFormatter.string(from: convertedDate)
                
                self._date = "\(currentDate)"
                self._weatherType = json["weather"][0]["main"].stringValue
                self._currentTemp = downloadedTemp! - 273.15
                self._cityName = json["name"].stringValue
                
                completed()
                
                //print(response)              //print json get data
                //print("========================")
                //print(result.value)
        }
    }
}
