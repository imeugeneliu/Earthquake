//
//  api_url.swift
//  Earthquake
//
//  Created by Eugene Liu on 6/7/18.
//  Copyright © 2018 Eugene Liu. All rights reserved.
//

import Foundation

let API_URL = "http://api.openweathermap.org/data/2.5/weather?lat=\(Location.sharedInstance.lat!)&lon=\(Location.sharedInstance.long!)&appid=786145db742633c8f186747b30e85de6"

let forecast_API_URL = "api.openweathermap.org/data/2.5/forecast/daily?lat=35&lon=139&cnt=10&appid=786145db742633c8f186747b30e85de6"

typealias DownloadComplete = () -> ()
