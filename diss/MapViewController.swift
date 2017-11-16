//
//  MapViewController.swift
//  diss
//
//  Created by Ксения Полянцева on 13.11.17.
//  Copyright © 2017 Ксения Полянцева. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Alamofire
import SwiftyJSON

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var speedLable: UILabel!
    @IBOutlet weak var latLable: UILabel!
    @IBOutlet weak var longLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    let URL_COORD_REGISTER = "http://ksssq.online/v1/addCoord.php";
    let locationManager = CLLocationManager()
    var countLM:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // For use when the app is open & in the background
        //locationManager.requestAlwaysAuthorization()
        
        // For use when the app is open
        locationManager.requestWhenInUseAuthorization()
        
        // If location services is enabled get the users location
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest // You can change the locaiton accuary here.
            locationManager.startUpdatingLocation()
            mapView.showsUserLocation = true
            mapView.showsTraffic = true
            mapView.showsBuildings = true
            mapView.showsPointsOfInterest = true
        }
    }
    // Print out the location to the console
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            if (countLM == 0){
                let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, 2000, 2000)
                mapView.setRegion(coordinateRegion, animated: true)
                latLable.isEnabled = true
                longLabel.isEnabled = true
                speedLable.isEnabled = true
            }
            countLM = countLM + 1
            latLable.text = String(location.coordinate.latitude)
            longLabel.text = String(location.coordinate.longitude)
            speedLable.text = String(Double(round(100*location.speed * 3.6)/100))
            print(location.coordinate)
            
            ///////////////////////////
            
            
            //creating parameters for the post request
            let parameters: Parameters=[
                "Latitude":latLable.text!,
                "Longitude":longLabel.text!,
                "UserID":USID,
                ]
            
            //Sending http post request
            Alamofire.request(URL_COORD_REGISTER, method: .post, parameters: parameters).responseJSON
                {
                    response in
                    //printing response
                    print(response)
            }
            
        }
    }
    
    // If we have been deined access give the user the option to change it
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if(status == CLAuthorizationStatus.denied) {
            showLocationDisabledPopUp()
        }
    }
    
    // Show the popup to the user if we have been deined access
    func showLocationDisabledPopUp() {
        let alertController = UIAlertController(title: "Background Location Access Disabled",
                                                message: "In order to deliver pizza we need your location",
                                                preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        let openAction = UIAlertAction(title: "Open Settings", style: .default) { (action) in
            if let url = URL(string: UIApplicationOpenSettingsURLString) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        alertController.addAction(openAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
}
