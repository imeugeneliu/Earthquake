//
//  mapViewController.swift
//  Earthquake
//
//  Created by Eugene Liu on 6/26/18.
//  Copyright © 2018 Eugene Liu. All rights reserved.
//

import UIKit
import MapKit

class mapViewController: UIViewController
{

    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let geoCoder = CLGeocoder()
        
        //print(restaurant.location)
        geoCoder.geocodeAddressString(earthquakeCenter, completionHandler: {placemarks, error in
            if let error = error
            {
                print("Geocoder error: \(error.localizedDescription)")
                return
            }
            if let placemarks = placemarks
            {
                let placemark = placemarks[0]
                let annotation = MKPointAnnotation()
                //annotation.title = self.restaurant.name
                //annotation.subtitle = self.restaurant.type
                if let location = placemark.location
                {
                    annotation.coordinate = location.coordinate
                    //                    self.mapView.addAnnotation(annotation)
                    //                    let region = MKCoordinateRegionMakeWithDistance(annotation.coordinate, 250, 250)
                    //                    self.mapView.setRegion(region, animated: false)
                    self.mapView.showAnnotations([annotation], animated: true)
                    self.mapView.selectAnnotation(annotation, animated: true)
                }
            }
            
        })
        
//        var locationArray: [String] = [""]
//        var simpleLocationArray: [String] = [""]
        /*for j in 0..<10
        {
            locationArray[j] = info2d[3][j]
            simpleLocationArray[j] = String(locationArray[j].prefix(3))
            print(simpleLocationArray[j])
        }*/
//        locationArray[0] = info2d[3][indexPath.row]
//        simpleLocationArray[0] = String(locationArray[0].prefix(3))
//        print(simpleLocationArray[0])
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
