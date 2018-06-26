//
//  ViewController.swift
//  Earthquake
//
//  Created by Eugene Liu on 6/7/18.
//  Copyright © 2018 Eugene Liu. All rights reserved.
//

import UIKit
import CoreLocation
import UserNotifications

class ViewController: UIViewController, CLLocationManagerDelegate
{
    @IBOutlet weak var sideView: UIView!
    @IBOutlet weak var blurView: UIVisualEffectView!
    @IBOutlet weak var viewConstraint: NSLayoutConstraint!

    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var currentDate: UILabel!
    @IBOutlet weak var currentCityTemp: UILabel!
    @IBOutlet weak var weatherType: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    
    let locationManager = CLLocationManager()
    var CurrentWeather: currentWeather!
    var currentLocation: CLLocation!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        blurView.layer.cornerRadius = 15
        sideView.layer.shadowColor = UIColor.black.cgColor
        sideView.layer.shadowOpacity = 0.8
        sideView.layer.shadowOffset = CGSize(width: 5, height: 0)
        viewConstraint.constant = -175                                     //hide slideView
        
        //weather app
        CurrentWeather = currentWeather()
        callDelegates()
        setupLocation()
        
        //local notifications
        let content = UNMutableNotificationContent()
        content.title = "最新地震消息"
        content.body = "\(outputdata)"
        content.sound = UNNotificationSound.default()
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(identifier: "testIdentifier", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        locationAuthCheck()
        //viewConstraint.constant = -175                                     //hide slideView
        
        //        CurrentWeather = currentWeather()                          //if uncomment, cannot get weather info
        //        callDelegates()
        //        setupLocation()
        
    }
    
    func callDelegates()
    {
        locationManager.delegate = self
    }
    
    func setupLocation()
    {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()                 //take permission from the user
        locationManager.startMonitoringSignificantLocationChanges()     //only get location when significant changes in distance
    }
    
    func locationAuthCheck()                                            //user gives us permission or not
    {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse
        {
            //get the location from device
            currentLocation = locationManager.location
            
            //pass the location coord to our api
            Location.sharedInstance.lat = currentLocation.coordinate.latitude
            Location.sharedInstance.long = currentLocation.coordinate.longitude
            
            //download api data
            CurrentWeather.downloadCurrentWeather
            {
                    //update the ui after download is complete
                    self.updateUI()
            }
        }
            
        else
        {
            //user didnt allow location
            locationManager.requestWhenInUseAuthorization()               //take permission again
            locationAuthCheck()                                           //make a check
        }
    }
    
    let hour = Calendar.current.component(.hour, from: Date())
    
    func updateUI()
    {
        if (CurrentWeather.cityName == "Buli")
        {
            cityName.text = "Puli"
        }
        else
        {
            cityName.text = CurrentWeather.cityName
        }
        //cityName.text = CurrentWeather.cityName
        currentCityTemp.text = "\(Int(CurrentWeather.currentTemp)) ˙C"
        weatherType.text = CurrentWeather.weatherType
        currentDate.text = CurrentWeather.date
        
        switch CurrentWeather.weatherType
        {
            case "Clear":
                if ((hour >= 6) && (hour <= 18))
                {
                    weatherImage.image = UIImage(named: "sunny")
                }
                else
                {
                    weatherImage.image = UIImage(named: "clearsky")
                }
            case "Rain":
                weatherImage.image = UIImage(named: "rainy")
            case "Drizzle":
                weatherImage.image = UIImage(named: "rainy")
            case "Clouds":
                weatherImage.image = UIImage(named: "partlycloudy")
            case "Snow":
                weatherImage.image = UIImage(named: "snowy")
            case "Thunderstorm":
                weatherImage.image = UIImage(named: "stormy")
            case "Mist":
                weatherImage.image = UIImage(named: "misty")
            case "Fog":
                weatherImage.image = UIImage(named: "fog")
            default:
                break
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle
    {
        return .lightContent
        //return .default
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func panPerformed(_ sender: UIPanGestureRecognizer)
    {
        if sender.state == .began || sender.state == .changed
        {
            let translation = sender.translation(in: self.view).x             //will give x and y value but only need x
            
            if translation > 0                                                //swipe right
            {
                if viewConstraint.constant < 20
                {
                    UIView.animate(withDuration: 0.2, animations: {self.viewConstraint.constant += translation / 10; self.view.layoutIfNeeded()})
                }
                
            }
            else                                                              //swipe left
            {
                if viewConstraint.constant > -175
                {
                    UIView.animate(withDuration: 0.2, animations: {self.viewConstraint.constant += translation / 10; self.view.layoutIfNeeded()})
                }
            }
        }
            
        else if sender.state == .ended
        {
            if viewConstraint.constant < -100
            {
                UIView.animate(withDuration: 0.2, animations: {self.viewConstraint.constant = -175; self.view.layoutIfNeeded()})
            }
            else
            {
                UIView.animate(withDuration: 0.2, animations: {self.viewConstraint.constant = 0; self.view.layoutIfNeeded()})
            }
        }
    }
}
