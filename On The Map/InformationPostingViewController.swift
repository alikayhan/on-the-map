//
//  InformationPostingViewController.swift
//  On The Map
//
//  Created by Ali Kayhan on 25/06/16.
//  Copyright © 2016 Ali Kayhan. All rights reserved.
//

import UIKit
import MapKit

class InformationPostingViewController: BaseViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var locationPostingStackView: UIStackView!
    
    @IBOutlet weak var promptLabelTop: UILabel!
    @IBOutlet weak var promptLabelMiddle: UILabel!
    @IBOutlet weak var promptLabelBottom: UILabel!
    
    @IBOutlet weak var promptLabelBackgroundView: UIView!
    
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var findOnTheMapButton: UIButton!
   
    
    @IBOutlet weak var findOnTheMapButtonBackgroundView: UIView!
    @IBOutlet weak var URLPostingStackView: UIStackView!
    
    @IBOutlet weak var URLTextField: UITextField!
    @IBOutlet var locationMapView: MKMapView!
    @IBOutlet weak var submitButtonBackgroundView: UIView!
    @IBOutlet weak var submitButton: UIButton!

    // MARK: - Lifecycle Functions
    override func viewWillAppear(animated: Bool) {
        tabBarController?.tabBar.hidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(activityIndicator)
        activityIndicator.center = view.center
        
        configureLocationPostingStackView()
        configureURLPostingStackView()
        
        showLocationPostingStackView()
    }
    
    // MARK: - Actions
    @IBAction func findOnTheMap(sender: UIButton) {
        if locationTextField.text!.isEmpty {
            showAlert(UIConstants.ErrorTitle.NoLocation, message: UIConstants.ErrorMessage.NoLocation)
        } else {
            startActivityIndicator()
            showPinOnTheMap(locationTextField.text!)
        }
    }
    
    @IBAction func submit(sender: UIButton) {
        startActivityIndicator()
        appDelegate.studentInformationDictionary[ParseClient.JSONBodyKeys.MediaURL] = URLTextField.text
        
        let loggedInStudentInformation = StudentInformation(dictionary: appDelegate.studentInformationDictionary)
        
        if appDelegate.studentHasAlreadyPosted != nil && appDelegate.studentHasAlreadyPosted! {
            updateStudentInformation(loggedInStudentInformation)
        } else {
            postStudentInformation(loggedInStudentInformation)
        }
    }
    
    // MARK: - Helpers
    private func postStudentInformation(loggedInStudentInformation: StudentInformation) {
        ParseClient.sharedInstance().postStudentLocation(loggedInStudentInformation, completionHandlerForPostStudentLocation: completePostingOrUpdating)
    }

    private func updateStudentInformation(loggedInStudentInformation: StudentInformation) {
        ParseClient.sharedInstance().updateStudentLocation(loggedInStudentInformation,completionHandlerForUpdateStudentLocation: completePostingOrUpdating)
    }
    
    private func completePostingOrUpdating(result: String?, error: NSError?) -> Void {
        if let result = result {
            print(result)
            stopActivityIndicator()
            performUIUpdatesOnMain() {
                self.navigationController?.popToRootViewControllerAnimated(true)
            }
        } else {
            print(error)
            stopActivityIndicator()
            performUIUpdatesOnMain() {
                self.showAlert(UIConstants.ErrorTitle.PostingFailed, message: UIConstants.ErrorMessage.PostingFailed)
            }
        }
    }

}


// MARK: - InformationPostingViewController: UITextFieldDelegate

extension InformationPostingViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    private func resignIfFirstResponder(textField: UITextField) {
        if textField.isFirstResponder() {
            textField.resignFirstResponder()
        }
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        textField.placeholder = ""
        textField.text = ""
    }
    
}


// MARK: - InformationPostingViewController (Configure UI)

extension InformationPostingViewController {
    
    private func showLocationPostingStackView() {
        locationPostingStackView.hidden = false
        URLPostingStackView.hidden = true
        submitButtonBackgroundView.hidden = true
    }
    
    private func showURLPostingStackView() {
        locationPostingStackView.hidden = true
        URLPostingStackView.hidden = false
        submitButtonBackgroundView.hidden = false
    }
    
    private func configureLocationPostingStackView() {
        configurePromptLabel(promptLabelTop, text: UIConstants.Title.PromptLabelTopTitle, font: UIConstants.Fonts.PromptLabelRegularFont!)
        configurePromptLabel(promptLabelMiddle, text: UIConstants.Title.PromptLabelMiddleTitle, font: UIConstants.Fonts.PromptLabelMediumFont!)
        configurePromptLabel(promptLabelBottom, text: UIConstants.Title.PromptLabelBottomTitle, font: UIConstants.Fonts.PromptLabelRegularFont!)
        
        configureButton(findOnTheMapButton, title: UIConstants.Title.FindOnTheMapButtonTitle)
        
        promptLabelBackgroundView.backgroundColor = UIConstants.Color.GreyColor
        findOnTheMapButtonBackgroundView.backgroundColor = UIConstants.Color.GreyColor
        
        locationTextField.tag = 1
        configureTextField(locationTextField)
    }
    
    private func configureURLPostingStackView() {
        locationMapView.delegate = self
        
        configureButton(submitButton, title: UIConstants.Title.SubmitButtonTitle)
        submitButtonBackgroundView.backgroundColor = UIConstants.Color.GreyColor.colorWithAlphaComponent(0.6)
        
        URLTextField.tag = 2
        configureTextField(URLTextField)
    }
    
    private func configurePromptLabel(promptLabel: UILabel, text: String, font: UIFont) {
        promptLabel.textColor = UIConstants.Color.UdacityBlue
        promptLabel.textAlignment = .Center
        promptLabel.backgroundColor = UIConstants.Color.GreyColor
        promptLabel.text = text
        promptLabel.font = font
        promptLabel.backgroundColor = UIConstants.Color.GreyColor
    }
    
    private func configureTextField(textField: UITextField) {
        switch textField.tag {
        case 1:
            textField.placeholder = UIConstants.Placeholder.LocationTextFieldPlaceholder
            textField.keyboardType = .Default
        case 2:
            textField.placeholder = UIConstants.Placeholder.URLTextFieldPlaceholder
            textField.keyboardType = .URL
        default:
            break
        }
        
        textField.autocorrectionType = .No
        textField.textAlignment = .Center
        
        textField.backgroundColor = UIConstants.Color.UdacityBlue
        textField.font = UIConstants.Fonts.InformationPostingPageTextFieldRegularFont
        textField.textColor = UIColor.whiteColor()
        
        textField.attributedPlaceholder = NSAttributedString(string: textField.placeholder!, attributes: [NSFontAttributeName : UIConstants.Fonts.InformationPostingPageTextFieldRegularFont!])
        
        textField.tintColor = UIColor.whiteColor()
        textField.delegate = self
    }
    
    private func configureButton(button: UIButton, title: String) {
        
        button.setTitle(title, forState: .Normal)
        button.titleLabel?.textAlignment = .Center
        button.titleLabel?.textColor = UIConstants.Color.UdacityBlue
        button.backgroundColor = UIColor.whiteColor()
        button.titleLabel?.font = UIConstants.Fonts.InformationPostingPageButtonRegularFont
        
        button.layer.cornerRadius = 4.0
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.whiteColor().CGColor
        button.contentEdgeInsets = UIEdgeInsetsMake(7, 7, 7, 7)
    }

}


// MARK: - InformationPostingViewController: MKMapViewDelegate

extension InformationPostingViewController: MKMapViewDelegate {
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        
        let reuseId = "pin"
        var pinView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.pinTintColor = UIColor.redColor()
        }
        else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }

    private func showPinOnTheMap(stringToGeocode: String) {
        
        let geocoder = CLGeocoder()
        let annotation = MKPointAnnotation()
        
        geocoder.geocodeAddressString(stringToGeocode) {
            (placemarks, error) in
            
            guard let placemarks = placemarks else {
                self.stopActivityIndicator()
                self.showAlert(UIConstants.ErrorTitle.GeocodingFailed, message: UIConstants.ErrorMessage.GeocodingFailed)
                return
            }
            
            let placemark = placemarks[0]
            
            // Determine the coordinate for annotation
            let latitude = placemark.location?.coordinate.latitude
            let longitude = placemark.location?.coordinate.longitude
            let coordinate = CLLocationCoordinate2D(latitude: latitude!, longitude: longitude!)
            annotation.coordinate = coordinate
            
            // Add annotation to map
            self.locationMapView.addAnnotation(annotation)
            
            // Add determined latitude, longitude and the map string entered
            // by user to StudentInformationDictionary.
            self.appDelegate.studentInformationDictionary[ParseClient.JSONBodyKeys.MapString] = stringToGeocode
            self.appDelegate.studentInformationDictionary[ParseClient.JSONBodyKeys.Latitude] = Double(latitude!)
            self.appDelegate.studentInformationDictionary[ParseClient.JSONBodyKeys.Longitude] = Double(longitude!)
            
            // Perform UI updates while showing and zooming into the map
            self.stopActivityIndicator()
            performUIUpdatesOnMain {
                self.showURLPostingStackView()
                self.zoomToPin(annotation)
            }
        }
    }
    
    private func zoomToPin(annotation: MKPointAnnotation) {
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegion(center: annotation.coordinate, span: span)
        self.locationMapView.setRegion(region, animated: true)
    }
}
