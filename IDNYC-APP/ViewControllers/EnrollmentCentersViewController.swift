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
    
    var currentBorough: String = "None"
    
    let boroughsLatAndLog:[String:(lat: Double,long: Double)] = ["All Boroughs":(40.7128, -74.0060),
                                                                 "Queens":(40.7282, -73.7949),
                                                                 "Manhattan":(40.7831, -73.9712),
                                                                 "Brooklyn":(40.6782, -73.9442),
                                                                 "The Bronx":(40.8448, -73.8648),
                                                                 "Staten Island":(40.5795, -74.1502)]
    
    var idnycCenters = [IDNYCCenter]() {
        didSet {
            DispatchQueue.main.async{
                self.filteredCenters = self.idnycCenters
                self.showCenters(centers: self.filteredCenters)
            }
        }
    }
    
    var filteredCenters = [IDNYCCenter]()
    
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
        // TODO: check if compass padding works well on all devices
        let mapInsets = UIEdgeInsets(top: 40.0, left: 0.0, bottom: 0.0, right: 0.0)
        enrollmentCentersView.centersMapView.padding = mapInsets
        //navigationController?.navigationBar.prefersLargeTitles = true
        //navigationItem.largeTitleDisplayMode = .automatic
        self.navigationController?.navigationBar.titleTextAttributes = [ NSAttributedStringKey.font: UIFont(name: "Verdana-Bold", size: UIFont.systemFontSize)! ]
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "centersList"), style: .plain, target: self, action: #selector(showCentersList))
    }
    
    @objc private func showCentersList() {
        let centersListVC = CentersListViewController(centers: filteredCenters)
        navigationController?.pushViewController(centersListVC, animated: true)
    }
    
    private func showCenters(centers: [IDNYCCenter]) {
        for center in centers {
            guard let location = center.location_1 else {
                continue
            }
            let position = CLLocationCoordinate2D(latitude: location.coordinates[1], longitude: location.coordinates[0])
            let centerLocation = GMSMarker(position: position)
            centerLocation.appearAnimation = .pop
            centerLocation.title = center.name
            centerLocation.snippet = "\(center.address1), \(center.city), \(center.zip)"
            centerLocation.icon = #imageLiteral(resourceName: "centerLocationTall")
            centerLocation.map = self.enrollmentCentersView.centersMapView
        }
    }

}

// MARK: LocationServiceDelegate
extension EnrollmentCentersViewController: LocationServiceDelegate {
    
    func updateLocation(with lat: Double, and long: Double) {
        enrollmentCentersView.centersMapView.isMyLocationEnabled = true
        let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: long, zoom: 13)
        enrollmentCentersView.centersMapView.animate(to: camera)
    }
    
}

// MARK: GMSMapViewDelegate
extension EnrollmentCentersViewController: GMSMapViewDelegate {
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        let camera = GMSCameraPosition.camera(withLatitude: marker.position.latitude, longitude: marker.position.longitude, zoom: 15)
        enrollmentCentersView.centersMapView.animate(to: camera)
        // return false to let the delegate method continue to also show info box
        return false
    }
    
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        // TODO: try to do this only when arrow button is tapped
        // TODO: handle when user did not enable location permission
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

// MARK: UICollectionViewDataSource
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

// MARK: UICollectionViewDelegate
extension EnrollmentCentersViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let tappedBorough = boroughs[indexPath.row]
        if tappedBorough == currentBorough { return }
        
        currentBorough = tappedBorough
        enrollmentCentersView.centersMapView.clear()
        let camera = GMSCameraPosition.camera(withLatitude: boroughsLatAndLog[tappedBorough]!.lat, longitude: boroughsLatAndLog[tappedBorough]!.long, zoom: 10)
        enrollmentCentersView.centersMapView.animate(to: camera)
        switch tappedBorough {
        case "All Boroughs":
            print("All Boroughs")
            filteredCenters = idnycCenters
            showCenters(centers: filteredCenters)
        case "Queens":
            print("Queens")
            filteredCenters = idnycCenters.filter{ $0.city.lowercased() == "flushing" ||
                                                      $0.city.lowercased() == "jamaica"  ||
                                                      $0.city.lowercased() == "corona"   ||
                                                      $0.city.lowercased() == "long island city" ||
                                                      $0.city.lowercased() == "queens" ||
                                                      $0.city.lowercased() == "briarwood" ||
                                                      $0.city.lowercased() == "jackson heights" }
            showCenters(centers: filteredCenters)
        case "Manhattan":
            print("Manhattan")
            filteredCenters = idnycCenters.filter{ $0.city.lowercased() == "new york" }
            showCenters(centers: filteredCenters)
        case "Brooklyn":
            print("Brooklyn")
            filteredCenters = idnycCenters.filter{ $0.city.lowercased() == "brooklyn" }
            showCenters(centers: filteredCenters)
        case "The Bronx":
            print("The Bronx")
            filteredCenters = idnycCenters.filter{ $0.city.lowercased() == "bronx" }
            showCenters(centers: filteredCenters)
        case "Staten Island":
            print("Staten Island")
            filteredCenters = idnycCenters.filter{ $0.city.lowercased() == "staten island" }
            showCenters(centers: filteredCenters)
        default:
            print("None")
        }
        enrollmentCentersView.centersMapView.animate(to: camera)
    }
}

