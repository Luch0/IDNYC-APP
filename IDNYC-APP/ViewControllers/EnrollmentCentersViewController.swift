//
//  EnrollmentCentersViewController.swift
//  IDNYC-APP
//
//  Created by Luis Calle on 4/24/18.
//  Copyright © 2018 Lucho. All rights reserved.
//

import UIKit
import GoogleMaps

class EnrollmentCentersViewController: UIViewController {

    let enrollmentCentersView = EnrollmentCentersView()
    
    let boroughs: [String] = ["All Boroughs", "Queens", "Manhattan", "Brooklyn", "The Bronx", "Staten Island"]
    
    var idnycCenters = [IDNYCCenter]() {
        didSet {
            DispatchQueue.main.async{
                for center in self.idnycCenters {
                    guard let location = center.location_1 else {
                        print(center.address1)
                        continue
                    }
                    let position = CLLocationCoordinate2D(latitude: location.coordinates[1], longitude: location.coordinates[0])
                    let centerLocation = GMSMarker(position: position)
                    centerLocation.title = center.name
                    centerLocation.snippet = "\(center.address1), \(center.city), \(center.zip)"
                    centerLocation.icon = #imageLiteral(resourceName: "centerLocationTall")
                    centerLocation.map = self.enrollmentCentersView.centersMapView
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(enrollmentCentersView)
        let _ = LocationService.manager.checkForLocationServices()
        enrollmentCentersView.boroughsCollectionView.dataSource = self
        enrollmentCentersView.boroughsCollectionView.delegate = self
        enrollmentCentersView.centersMapView.delegate = self
        LocationService.manager.delegate = self
        fetchEnrollmentCenters()
        setupNavBar()
        if let flowLayout = enrollmentCentersView.boroughsCollectionView.collectionViewLayout as? UICollectionViewFlowLayout { flowLayout.estimatedItemSize = CGSize(width: 1, height: 1) }
    }
    
    private func fetchEnrollmentCenters() {
        IDNYCCentersAPIClient.manager.getEnrollmetCenters(with: "11385", completionHandler: {
            self.idnycCenters = $0
        }, errorHandler: { print($0) })
    }
    
    private func setupNavBar() {
        navigationItem.title = "Enrollment Centers"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "centersList"), style: .plain, target: self, action: #selector(showCentersList))
    }
    
    @objc private func showCentersList() {
        // TODO: show centers as list in tableView
        print("Will show list of centers: comming soon...")
    }

}

extension EnrollmentCentersViewController: LocationServiceDelegate {
    
    func updateLocation(with lat: Double, and long: Double) {
        enrollmentCentersView.centersMapView.isMyLocationEnabled = true
        let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: long, zoom: 13)
        enrollmentCentersView.centersMapView.animate(to: camera)
    }
    
}

extension EnrollmentCentersViewController: GMSMapViewDelegate {
    
    // TODO: figure out how to show info windows from here as well
//    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
//        let camera = GMSCameraPosition.camera(withLatitude: marker.position.latitude, longitude: marker.position.longitude, zoom: 13)
//        enrollmentCentersView.centersMapView.animate(to: camera)
//        return true
//    }
    
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        // TODO: try to do this only when arrow button is tapped
        let userCoordinate = CLLocationCoordinate2D(latitude: LocationService.manager.getCurrentLatitude()!, longitude: LocationService.manager.getCurrentLongitude()!)
        //let placeCoordinate = CLLocationCoordinate2D(latitude: marker.position.latitude, longitude: marker.position.longitude)
        
        if (UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!)) {
            UIApplication.shared.open(URL(string: "comgooglemaps://?saddr=\(userCoordinate.latitude),\(userCoordinate.longitude)&daddr=\(marker.snippet!.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!)")!, options: [:], completionHandler: nil)
        } else {
            print("Can't use comgooglemaps://")
            UIApplication.shared.open(URL(string: "http://maps.apple.com/?saddr=\(userCoordinate.latitude),\(userCoordinate.longitude)&daddr=\(marker.snippet!.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!)")!, options: [:], completionHandler: nil)
        }
    }
    
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
        let customInfoView = Bundle.main.loadNibNamed("CustomInfoView", owner: self, options: nil)![0] as! CustomInfoView
        customInfoView.nameLabel.text = marker.title
        customInfoView.addressLabel.text = marker.snippet
        customInfoView.backgroundColor = .clear
        return customInfoView
    }
    
}

extension EnrollmentCentersViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return boroughs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let boroughCell = collectionView.dequeueReusableCell(withReuseIdentifier: "boroughCell", for: indexPath) as! BoroughCollectionViewCell
        boroughCell.boroughNameLabel.text = boroughs[indexPath.row]
        boroughCell.boroughNameLabel.preferredMaxLayoutWidth = 50
        return boroughCell
    }
    
}

extension EnrollmentCentersViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch boroughs[indexPath.row] {
        case "All Boroughs":
            print("All Boroughs")
        case "Queens":
            print("Queens")
        case "Manhattan":
            print("Manhattan")
        case "Brooklyn":
            print("Brooklyn")
        case "The Bronx":
            print("The Bronx")
        case "Staten Island":
            print("Staten Island")
        default:
            print("None")
        }
    }
}

