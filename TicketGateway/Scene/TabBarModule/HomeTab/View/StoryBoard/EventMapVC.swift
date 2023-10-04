//
//  EventMapVC.swift
//  TicketGateway
//
//  Created by Apple on 27/07/23.
//

import UIKit
import MapKit

class EventMapVC: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var vwNavigationView: NavigationBarView!
    // MARK: - Varibles
    var latitude = Double()
    var longitude = Double()
    var location = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setMap()
        self.setNavigationBar()
    }
}
// MARK: - Functions
extension EventMapVC {
    func setNavigationBar() {
        self.vwNavigationView.delegateBarAction = self
        self.vwNavigationView.btnBack.isHidden = false
        self.vwNavigationView.vwBorder.isHidden = false 
    }
    func setMap() {
        let initialLocation = CLLocation(latitude: latitude, longitude: longitude)
        mapView.centerToLocation(initialLocation)
        let annotation = MKPointAnnotation()
        let centerCoordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        annotation.coordinate = centerCoordinate
        annotation.title = location
        mapView.addAnnotation(annotation)
    }

}
// MARK: - MKMapView
private extension MKMapView {
    func centerToLocation(_ location: CLLocation,regionRadius: CLLocationDistance = 1000
    ) {
        let coordinateRegion = MKCoordinateRegion(
            center: location.coordinate,
            latitudinalMeters: regionRadius,
            longitudinalMeters: regionRadius)
        setRegion(coordinateRegion, animated: true)
    }
}
// MARK: -
extension EventMapVC: NavigationBarViewDelegate {
    func navigationBackAction() {
        self.navigationController?.popViewController(animated: true)
    }
}
