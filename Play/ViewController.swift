//
//  ViewController.swift
//  Play
//
//  Created by admin on 06/04/17.
//  Copyright © 2017 ACE. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate,MKMapViewDelegate {

    @IBAction func locationReset(_ sender: AnyObject) {
        let region = MKCoordinateRegionMakeWithDistance(self.manager.location!.coordinate, 400, 400)
        self.mapView.setRegion(region, animated: true)

    }
    @IBOutlet weak var mapView: MKMapView!
    var pokemon : [Pokemon] = []
    var manager = CLLocationManager()
    var update = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Checking the authorization status of the map, required for the app:
        self.manager.delegate = self
        self.mapView.delegate = self
        self.manager.startUpdatingLocation()
        pokemon = bringAllPokemon()
        if (CLLocationManager.authorizationStatus() == .authorizedWhenInUse){
            self.mapView.showsUserLocation = true
            self.manager.startUpdatingLocation()
            pokemon = bringAllPokemon()
            //placing timer and annotations so that annotations occur every 4 seconds at different locations
            Timer.scheduledTimer(withTimeInterval: 4, repeats: true, block: {
            (timer) in
            if let coordinate = self.manager.location?.coordinate
            {
                let randomPokemon = Int(arc4random_uniform(UInt32(self.pokemon.count)))
                let pokemon = self.pokemon[randomPokemon]
                let annotation = PokemonAnnotation(coordinate: coordinate, pokemon: pokemon)
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
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationview = MKAnnotationView(annotation: annotation, reuseIdentifier: nil)
        if annotation is MKUserLocation{
            annotationview.image = #imageLiteral(resourceName: "player")
        }
        else{
            let pokemon = (annotation as! PokemonAnnotation).pokemon
            annotationview.image = UIImage(named:pokemon.imageFileName!)
        }
        var newframe = annotationview.frame
        newframe.size.width = 40
        newframe.size.height = 40
        annotationview.frame = newframe
        return annotationview
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
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        //on typing select annotations we get suggestions automativcally just look for the synonyms of the word you want to imply
        mapView.deselectAnnotation(view.annotation!, animated: true)
        if view.annotation! is MKUserLocation{
            //Checking whether the selected annotation is user
            return
        }
        //Making the region smaller and zooming in on the pokemon
        let region = MKCoordinateRegionMakeWithDistance((view.annotation?.coordinate)!,150 , 150)
        self.mapView.setRegion(region, animated: true)
        if let coordinate = self.manager.location?.coordinate{
            if MKMapRectContainsPoint(mapView.visibleMapRect, MKMapPointForCoordinate(coordinate)){
                //passing the selected pokemon to battle view controller
                let battle = BattleViewController()
                let pokemon = (view.annotation as! PokemonAnnotation).pokemon
                battle.pokemon = pokemon
                //Making a segue from view controller to battle view controller
                self.present(battle, animated: true, completion: nil)
                print("in range")
            }
            else{
                print("out of range")
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

