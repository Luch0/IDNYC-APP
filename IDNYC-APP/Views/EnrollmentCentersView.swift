//
//  EnrollmentCentersView.swift
//  IDNYC-APP
//
//  Created by Luis Calle on 4/24/18.
//  Copyright © 2018 Lucho. All rights reserved.
//

import UIKit
import GoogleMaps

class EnrollmentCentersView: UIView {
    
    lazy var boroughsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 5
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.register(BoroughCollectionViewCell.self, forCellWithReuseIdentifier: "boroughCell")
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    lazy var swipeForMoreBoroughsLabel: UILabel = {
        let label = UILabel()
        label.text = "  ←   Scroll   →  \u{200c}"
        label.backgroundColor = UIColor(displayP3Red: 214/256, green: 71/256, blue: 41/256, alpha: 1.0)
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name: "Verdana-Bold", size: 16)
        return label
    }()
    
    lazy var centersMapView: GMSMapView = {
        let camera = GMSCameraPosition.camera(withLatitude: 40.6971494, longitude: -74.2598719, zoom: 5)
        var mapView = GMSMapView.map(withFrame: frame, camera: camera)
        mapView.settings.myLocationButton = true
        mapView.settings.compassButton = true
        mapView.settings.tiltGestures = true
        return mapView
    }()

    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = .white
        setupViews()
    }
    
    override func layoutSubviews() {
        swipeForMoreBoroughsLabel.layer.cornerRadius = 8
        swipeForMoreBoroughsLabel.layer.masksToBounds = true
        if LanguageUserDefaultsHelper.manager.getSelectedLanguage()! == "English" {
            swipeForMoreBoroughsLabel.text = "  ←   Scroll   →  \u{200c}"
        } else {
            swipeForMoreBoroughsLabel.text = "  ←   Deslizar   →  \u{200c}"
        }
    }
    
    private func setupViews() {
        setupCentersMapView()
        setupBoroughCollectionView()
        setupSwipeForMoreBoroughsLabel()
    }
    
    private func setupCentersMapView() {
        addSubview(centersMapView)
        centersMapView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            centersMapView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            centersMapView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            centersMapView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            centersMapView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            centersMapView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor)
        ])
    }
    
    private func setupBoroughCollectionView() {
        addSubview(boroughsCollectionView)
        boroughsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            boroughsCollectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            boroughsCollectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            boroughsCollectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            boroughsCollectionView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            boroughsCollectionView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.1)
        ])
    }
    
    private func setupSwipeForMoreBoroughsLabel() {
        addSubview(swipeForMoreBoroughsLabel)
        swipeForMoreBoroughsLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            swipeForMoreBoroughsLabel.topAnchor.constraint(equalTo: boroughsCollectionView.bottomAnchor),
            swipeForMoreBoroughsLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor)
            ])
    }

}
