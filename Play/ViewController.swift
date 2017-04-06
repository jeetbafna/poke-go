//
//  ViewController.swift
//  Play
//
//  Created by admin on 06/04/17.
//  Copyright © 2017 ACE. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBAction func locationReset(_ sender: AnyObject) {
        let region = MKCoordinateRegionMakeWithDistance(self.manager.location!.coordinate, 400, 400)
        self.mapView.setRegion(region, animated: true)

    }
    @IBOutlet weak var mapView: MKMapView!
    var manager = CLLocationManager()
    var update = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Checking the authorization status of the map, required for the app:
        self.manager.delegate = self
        if (CLLocationManager.authorizationStatus() == .authorizedWhenInUse){
            self.mapView.showsUserLocation = true
            self.manager.startUpdatingLocation()
            Timer.scheduledTimer(withTimeInterval: 4, repeats: true, block: {
            (timer) in
            if let coordinate = self.manager.location?.coordinate
            {
                let annotation = MKPointAnnotation()
                annotation.coordinate = coordinate
                annotation.coordinate.latitude += (Double(arc4random_uniform(1000)) - 500) / 300000.0
                annotation.coordinate.longitude += (Double(arc4random_uniform(1000)) - 500) / 300000.0
                self.mapView.addAnnotation(annotation)
                
                
            }
            
        }
            )
        }
        else {
            //Requesting authorization when not found:
            self.manager.requestWhenInUseAuthorization()
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //setting the region of the map
        if update<4{
                //it will update the map only for 4 times if it doesnt change if it changes then it updates again
                let region = MKCoordinateRegionMakeWithDistance(self.manager.location!.coordinate, 400, 400)
                self.mapView.setRegion(region, animated: true)
                update += 1
                }
        else{
            self.manager.stopUpdatingLocation()
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

