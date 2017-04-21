//
//  ViewController.swift
//  Traweather
//
//  Created by Jiayi Zou on 4/20/17.
//  Copyright © 2017 SU. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

protocol HandleMapSearch {
    func dropPinZoomIn(placemark:MKPlacemark)
}

class ViewController : UIViewController , HandleMapSearch {
    func dropPinZoomIn(placemark: MKPlacemark) {
        // cache the pin
        selectedPin = placemark
        // clear existing pins
        mapView.removeAnnotations(mapView.annotations)
        let annotation = MKPointAnnotation()
        annotation.coordinate = placemark.coordinate
        annotation.title = placemark.name
        if let city = placemark.locality,
            let state = placemark.administrativeArea {
            annotation.subtitle = "\(city) \(state)"
        }
        mapView.addAnnotation(annotation)
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegionMake(placemark.coordinate, span)
        mapView.setRegion(region, animated: true)
    }
    
    let locationManager:CLLocationManager = CLLocationManager()
    
    var resultSearchController:UISearchController? = nil
    var selectedPin:MKPlacemark? = nil
    
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.requestAlwaysAuthorization()
        self.mapView.mapType = MKMapType.standard
        self.mapView.userTrackingMode = MKUserTrackingMode.followWithHeading
        mapView.userTrackingMode = MKUserTrackingMode.followWithHeading
        
        
        let locationSearchTable = storyboard!.instantiateViewController(withIdentifier: "LocationSearchTable") as! LocationSearchTable
        locationSearchTable.mapView = mapView
        locationSearchTable.handleMapSearchDelegate = self
        resultSearchController = UISearchController(searchResultsController: locationSearchTable)
        resultSearchController?.searchResultsUpdater = locationSearchTable
        
        
        let searchBar = resultSearchController!.searchBar
        searchBar.sizeToFit()
        searchBar.placeholder = "Search for places"
        navigationItem.titleView = resultSearchController?.searchBar
        
        resultSearchController?.hidesNavigationBarDuringPresentation = false
        resultSearchController?.dimsBackgroundDuringPresentation = true
        definesPresentationContext = true
    }
    func makeVisitPoint(){
        if let selectedPin = selectedPin {
            //TODO:
            //添加跳转
            performSegue(withIdentifier: "confirmTravelPlace", sender: selectedPin)
            print(selectedPin.subAdministrativeArea!)
            print(selectedPin)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier=="confirmTravelPlace"{
            let confirmTravelPlace = segue.destination as! confirmTravelPlace
            confirmTravelPlace.place = sender as? MKPlacemark
        }
    }
}
extension ViewController : MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?{
        if annotation is MKUserLocation {
            //return nil so map view draws "blue dot" for standard user location
            return nil
        }
        let reuseId = "pin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
        pinView?.pinTintColor = UIColor.orange
        pinView?.canShowCallout = true
        let smallSquare = CGSize(width: 30, height: 30)
        let button = UIButton(frame: CGRect(origin: CGPoint.zero, size: smallSquare))
        button.setBackgroundImage(UIImage(named: "weather"), for: .normal)
        //change
        button.addTarget(self, action: #selector(self.makeVisitPoint), for: .touchUpInside)
        pinView?.leftCalloutAccessoryView = button
        return pinView
    }
    
}

