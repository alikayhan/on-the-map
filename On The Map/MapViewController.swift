//
//  MapViewController.swift
//  On The Map
//
//  Created by Ali Kayhan on 25/06/16.
//  Copyright © 2016 Ali Kayhan. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: BaseViewController, MKMapViewDelegate {
    
    // MARK: - Outlets
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var logoutButton: UIBarButtonItem!
    @IBOutlet weak var pinYourselfButton: UIBarButtonItem!
    @IBOutlet weak var refreshButton: UIBarButtonItem!
    
    // MARK: - Lifecycle Functions
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        tabBarController?.tabBar.hidden = false
        refreshMap()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        mapView.addSubview(activityIndicator)
        activityIndicator.center = view.center
    }
    
    // MARK: - MKMapViewDelegate
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.pinTintColor = UIColor.redColor()
            pinView!.rightCalloutAccessoryView = UIButton(type: .DetailDisclosure)
        }
        else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }

    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            openURL(view.annotation?.subtitle!)
        }
    }
    
    
    // MARK: - Populate Map Method
    private func populateMap() {
        
        // Create an MKPointAnnotation for each Student Location by using Student Information.
        // The point annotations will be stored in this array, and then provided to the map view.
        var annotations = [MKPointAnnotation]()
        
        for information in appDelegate.studentInformationArray {
            
            let lat = CLLocationDegrees(information.latitude)
            let long = CLLocationDegrees(information.longitude)
            
            let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
            
            let first = information.firstName
            let last = information.lastName
            let mediaURL = information.mediaURL
            
            // Create the annotation and set its coordinate, title, and subtitle properties
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = "\(first) \(last)"
            annotation.subtitle = mediaURL
            
            // Place the annotation in an array of annotations
            annotations.append(annotation)
        }
        
        // When the array is complete, add the annotations to the map
        self.mapView.addAnnotations(annotations)
    }
    
    // MARK: - Actions
    @IBAction func logout(sender: UIBarButtonItem) {
        logout()
    }
    
    @IBAction func refresh(sender: UIBarButtonItem) {
        refreshMap()
    }
    
    @IBAction func showPostingView(sender: UIBarButtonItem) {
        navigateToPostingView()
    }
    
    // MARK: - Helper Functions
    private func clearMap() {
        let annotations = mapView.annotations
        mapView.removeAnnotations(annotations)
    }
    
    private func refreshMap() {
        setUIEnabled(false)
        getStudentLocationsData() {
            self.clearMap()
            self.populateMap()
            self.setUIEnabled(true)
        }
    }
    
    private func setUIEnabled(enabled: Bool) {
        logoutButton.enabled = enabled
        pinYourselfButton.enabled = enabled
        refreshButton.enabled = enabled
    }
    
}
