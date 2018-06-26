//
//  modify.swift
//  Earthquake
//
//  Created by Eugene Liu on 6/7/18.
//  Copyright © 2018 Eugene Liu. All rights reserved.
//

import Foundation

extension Double
{
    func rounded(toPlaces places:Int) -> Double
    {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

extension Date
{
    func dayOfTheWeek() -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
    }
}
