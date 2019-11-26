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
import CoreMotion
var urlTrackCoord:String = ""

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var speedLable: UILabel!
    @IBOutlet weak var latLable: UILabel!
    @IBOutlet weak var longLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    let URL_GET_TRACK = "http://ec2-18-191-251-174.us-east-2.compute.amazonaws.com:3000";
    ////
    let MY_URL_ACC = "http://ksssq.online/v1/addCoord.php";
    let locationManager = CLLocationManager()
    var countLM:Int = 0
    var countTRACK:Int = 0
    var motionManager = CMMotionManager()
    var preX:Double = 0
    var preY:Double = 0
    var preZ:Double = 0
    var X:Double = 0
    var Y:Double = 0
    var Z:Double = 0
    var gyrX:Double = 0
    var gyrY:Double = 0
    var gyrZ:Double = 0
    var countFl:Int = 0
    var chX:Double = 0
    var chY:Double = 0
    var chZ:Double = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        // For use when the app is open
        locationManager.requestWhenInUseAuthorization()
        locationManager.allowsBackgroundLocationUpdates = true
        
        
        
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
    
    override func viewDidAppear(_ animated: Bool) {
        ///////
    }
    
    // Print out the location to the console
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let urlTrack = URL_GET_TRACK + "/track"
        if let location = locations.first {
            if (countLM == 0){
                Alamofire.request(urlTrack, method: .post, parameters: [:]).responseString
                    {
                        responseString in
                        print(responseString.result.value!)
                        var str = responseString.result.value!
                        var range = str.index(str.endIndex, offsetBy: -2)..<str.endIndex
                        str.removeSubrange(range)
                        range = str.startIndex..<str.index(str.startIndex, offsetBy: 8)
                        str.removeSubrange(range)
                        print(str)
                        urlTrackCoord = self.URL_GET_TRACK + str
                        print(urlTrackCoord)
                        self.countTRACK = 1
                }
                let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, 2000, 2000)
                mapView.setRegion(coordinateRegion, animated: true)
                //latLable.isEnabled = true
                //longLabel.isEnabled = true
                //speedLable.isEnabled = true
            }
            countLM = countLM + 1
            //latLable.text = String(location.coordinate.latitude)
            //longLabel.text = String(location.coordinate.longitude)
            //if location.speed > 0{
               // speedLable.text = String(Double(round(100*location.speed * 3.6)/100))
            //}else{
              //  speedLable.text = "0"
            //}
            //print(location.coordinate)
            
            let today = NSDate()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM-dd-yyyy hh:mm:ss"
            var string = dateFormatter.string(from: today as Date)
            string = string + " PM"
            print(string)
            
            ///////////////ACCCCCC
            
            motionManager.accelerometerUpdateInterval = 0.2
            motionManager.startAccelerometerUpdates(to: OperationQueue.current!) { (data, error) in
                if let myData = data{
                    
                    if self.countFl == 0 {
                        self.preX = myData.acceleration.x
                        self.preY = myData.acceleration.y
                        self.preZ = myData.acceleration.z
                    }
                    
                    self.X = myData.acceleration.x
                    self.Y = myData.acceleration.y
                    self.Z = myData.acceleration.z
                    
                    self.chX = abs(self.X - self.preX)
                    self.chY = abs(self.Y - self.preY)
                    self.chZ = abs(self.Z - self.preZ)
                    
                    
                    
                    self.preX = self.X
                    self.preY = self.Y
                    self.preZ = self.Z
                    self.countFl = self.countFl + 1

                    
                   // print(myData)
                   // if (self.chX > 3) {
                     //   self.view.backgroundColor = UIColor.red
                    //    print("DANGEROUS!")
                  //      self.view.backgroundColor = UIColor.white
                //    }
                }
            }
            
            ///////////////////////// GYRO
            motionManager.gyroUpdateInterval = 0.2
            motionManager.startGyroUpdates(to: OperationQueue.current!){ (data, error) in
                if let myDat = data{
                
                    //self.preX = myData.acceleration.x
                    self.gyrX = myDat.rotationRate.x
                    self.gyrY = myDat.rotationRate.y
                    self.gyrZ = myDat.rotationRate.z

                
            }
            }
            
            
            
            
            //creating parameters for the post request
            let point: Parameters=[
                "point": [
                "latitude":location.coordinate.latitude,
                "longitude":location.coordinate.longitude,
                "speed":Double(round(100*location.speed * 3.6)/100),
                "position":position,
                "accX":self.X,
                "accY":self.Y,
                "accZ":self.Z,
                "gyrX":self.gyrX,
                "gyrY":self.gyrY,
                "gyrZ":self.gyrZ,
                "road":road,
                "daytime":time,
                "tyre":tyre,
                "date":String(string),
                    ]
                ]
       
            Alamofire.request(urlTrackCoord, method: .post, parameters: point, encoding: JSONEncoding.default).responseString
                {
                    responseString in
                    //printing response
                    print("ОТВЕТ:")
                    print(responseString)
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
                                                message: "In order",
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
