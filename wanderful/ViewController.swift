//
//  ViewController.swift
//  wanderful
//
//  Created by David on 11/11/17.
//  Copyright © 2017 David. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class VacationDestination: NSObject {
    
    let name: String
    let location: CLLocationCoordinate2D
    let zoom: Float
    
    init(name: String, location: CLLocationCoordinate2D, zoom: Float) {
        self.name = name
        self.location = location
        self.zoom = zoom
    }
    
}

class ViewController: UIViewController {
    
    var mapView: GMSMapView?
    
    var currentDestination: VacationDestination?
    
    let destinations = [VacationDestination(name: "Embarcadero Bart Station", location: CLLocationCoordinate2DMake(37.792905, -122.397059), zoom: 14), VacationDestination(name: "Ferry Building", location: CLLocationCoordinate2DMake(37.795434, -122.39473), zoom: 18), VacationDestination(name: "Coit Tower", location: CLLocationCoordinate2DMake(37.802378, -122.405811), zoom: 15), VacationDestination(name: "Fisherman's Wharf", location: CLLocationCoordinate2DMake(37.808, -122.417743), zoom: 15), VacationDestination(name: "Golden Gate Bridge", location: CLLocationCoordinate2DMake(37.807664, -122.475069), zoom: 13)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GMSServices.provideAPIKey("AIzaSyA0QlNOrMY6JU7wqgBXBamQq1v9wbR11Z0")
        let camera = GMSCameraPosition.camera(withLatitude: 37.621262, longitude: -122.378945, zoom: 12)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView?.isMyLocationEnabled = true
        view = mapView
        
        
        let currentLocation = CLLocationCoordinate2DMake(37.621262, -122.378945)
        let marker = GMSMarker(position: currentLocation)
        marker.title = "SFO Airport"
        marker.map = mapView
        
    }
    
    @IBAction func nextback(_ sender: UIBarButtonItem) {
        if sender.tag == 0{
            if currentDestination == nil {
                currentDestination = destinations.first
            } else {
                if let index = destinations.index(of: currentDestination!), index < destinations.count - 1 {
                    print(index)
                    currentDestination = destinations[index + 1]
                    print(index)
                    }
                }
        
        }
        setMapCamera()
        if sender.tag == 1 {
            if let index = destinations.index(of: currentDestination!), index < destinations.count - 1 {
                print(index)
                currentDestination = destinations[index - 1]
                print(index)
                }
            }
        setMapCamera()
    }
    

    
    
    private func setMapCamera() {
        CATransaction.begin()
        CATransaction.setValue(2, forKey: kCATransactionAnimationDuration)
        mapView?.animate(to: GMSCameraPosition.camera(withTarget: currentDestination!.location, zoom: currentDestination!.zoom))
        CATransaction.commit()
        
        let marker = GMSMarker(position: currentDestination!.location)
        marker.title = currentDestination?.name
        marker.map = mapView
    }
    
}
