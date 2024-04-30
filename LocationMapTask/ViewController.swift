//
//  ViewController.swift
//  LocationMapTask
//
//  Created by SangeethaKalis on 30/04/24.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController,MKMapViewDelegate,CLLocationManagerDelegate {
    
    @IBOutlet weak var locationouterview: UIView!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var currentlatlabel: UILabel!
    @IBOutlet weak var currentlatvaluelabel: UILabel!
    @IBOutlet weak var currentlonglabel: UILabel!
    @IBOutlet weak var currentlongvaluelabel: UILabel!
    @IBOutlet weak var dividerview: UIView!
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initalsetup()
    }
    func initalsetup() {
        mapView.delegate = self
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        self.currentlatlabel.configureText(color: .black, alignment: .left, font: UIFont.systemFont(ofSize: 16), text: "Current Latitude")
        self.currentlonglabel.configureText(color: .black, alignment: .left, font: UIFont.systemFont(ofSize: 16), text: "Current Longitude")
        self.locationouterview.layer.cornerRadius = 12
        self.dividerview.backgroundColor = UIColor.gray
    }
    // MARK: - Location Manager Delegate
      
      func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
          guard let location = locations.last else { return }
          
          self.currentlatvaluelabel.configureText(color: .black, alignment: .left, font: UIFont.systemFont(ofSize: 16), text: "\(location.coordinate.latitude)")
          self.currentlongvaluelabel.configureText(color: .black, alignment: .left, font: UIFont.systemFont(ofSize: 16), text: "\(location.coordinate.longitude)")
          
          let regionRadius: CLLocationDistance = 1000 // 1 kilometer
          let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                    latitudinalMeters: regionRadius,
                                                    longitudinalMeters: regionRadius)
          mapView.setRegion(coordinateRegion, animated: true)
          
          let annotation = MKPointAnnotation()
          annotation.coordinate = location.coordinate
          annotation.title = "Current Location"
          mapView.addAnnotation(annotation)
          
          locationManager.stopUpdatingLocation()
      }
      
      func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
          print("Error: \(error.localizedDescription)")
      }
}
extension UILabel {
    // Function to configure text color, alignment, and font
    func configureText(color: UIColor?, alignment: NSTextAlignment, font: UIFont?,text: String) {
        // Set text color
        self.textColor = color ?? .black
        
        // Set text alignment
        self.textAlignment = alignment
        
        // Set font
        if let font = font {
            self.font = font
        }
        self.text = text
    }
}

