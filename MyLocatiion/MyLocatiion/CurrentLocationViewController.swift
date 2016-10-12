//
//  FirstViewController.swift
//  MyLocatiion
//
//  Created by yuvraj singh on 10/10/16.
//  Copyright © 2016 yuvraj singh. All rights reserved.
//

import UIKit
import CoreLocation

class CurrentLocationViewController: UIViewController, CLLocationManagerDelegate {
  
  
  let locationManager = CLLocationManager()
  var location: CLLocation?
  var updatingLocation = false
  var lastLocationError: NSError?
  
  
  
  
  
  
  @IBOutlet weak var messageLabel: UILabel!
  @IBOutlet weak var latitudeLabel: UILabel!
  @IBOutlet weak var longitudeLabel: UILabel!
  @IBOutlet weak var addressLabel: UILabel!
  @IBOutlet weak var tagButton: UIButton!
  @IBOutlet weak var getButton: UIButton!
  
  
 
  
  
  
  @IBAction func getLocation(_ sender: AnyObject) {
    
    let authStatus = CLLocationManager.authorizationStatus()
    
     if(authStatus == .notDetermined){
     locationManager.requestWhenInUseAuthorization()
     return
     }
    
    if authStatus == .denied || authStatus == .restricted {
      
      showLocationServicesDeniedAlert()
    }
    
    
    
    locationManager.delegate = self
    locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
    locationManager.startUpdatingLocation()
    startLocationManager()
    updateLabels()
  }
  
  
  func showLocationServicesDeniedAlert() {
    let alert = UIAlertController(title: "location Services Disabled",
                                  message: "pleaseenable location for this app in the settings",
                                  preferredStyle: .alert)
    let okAction = UIAlertAction(title: "ok",
                                 style: .default,
                                 handler: nil)
    alert.addAction(okAction)
    
    present(alert, animated: true, completion: nil)
  }
  
/*  @IBAction func getLocation(){
   let authStatus = CLLocationManager.authorizationStatus()
   
   /* if(authStatus == .NotDetermined){
   locationManager.requestWhenInUseAuthorization()
   return
   }
   */
   
    locationManager.delegate = self
    locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
    locationManager.startUpdatingLocation()
    
    
    
    
  }
 */
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    updateLabels()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  
  
  // MARK: - CLLocationManagerDelegate
  
  func locationManager(manager: CLLocationManager,
                       didUpdateLocations locations: [CLLocation]){
    
    let newLocation = locations.last!
    print("didupdatelocations \(newLocation)")
    
    lastLocationError = nil
    location = newLocation
    updateLabels()
  }
  func locationManager(_ manager: CLLocationManager, didFailWithError error: NSError) {
    print("did fail with error \(error)")
    if error.code == CLError.locationUnknown.rawValue{
      return
    }
    
    lastLocationError = error
    stopLocationManager()
    updateLabels()
  }
  
  
  
  func updateLabels() {
    if let location = location{
      latitudeLabel.text = String(format: "%.8f", location.coordinate.latitude)
      longitudeLabel.text = String(format: "%.8f", location.coordinate.longitude)
      
      
    }else{
      latitudeLabel.text = ""
      longitudeLabel.text = ""
      addressLabel.text = ""
      tagButton.isHidden = true
      
      
      let statusMessage: String
      if let error = lastLocationError {
        if error.domain == kCLErrorDomain && error.code == CLError.denied.rawValue {
          statusMessage = "location service disabled"
        }else {
          statusMessage = "error getting location"
        }
      } else if !CLLocationManager.locationServicesEnabled()  {
          statusMessage = "location services disabled"
      } else if updatingLocation{
         statusMessage = "searching..."
      } else {
        statusMessage = "tap 'get my location' to start"
      }
    }
  }
  func startLocationManager(){
    if CLLocationManager.locationServicesEnabled(){
      locationManager.delegate = self
      locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
      locationManager.startUpdatingLocation()
      updatingLocation = true
    }
  }
  
  func stopLocationManager(){
    if updatingLocation{
      locationManager.startUpdatingLocation()
      locationManager.delegate = nil
      updatingLocation = false
    }
  }
  

}

