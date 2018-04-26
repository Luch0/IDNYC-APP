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
        let cellSpacing: CGFloat = 1
        let numCells: CGFloat = 6
        let numSpaces: CGFloat = numCells + 1
        let itemWidth: CGFloat = ((bounds.width - (cellSpacing * numSpaces)) / numCells) * 1.5
        let itemHeight: CGFloat = bounds.height * 0.1
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = cellSpacing*5
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        layout.sectionInset = UIEdgeInsetsMake(cellSpacing, cellSpacing, cellSpacing, cellSpacing)
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.register(BoroughCollectionViewCell.self, forCellWithReuseIdentifier: "boroughCell")
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
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
    
    private func setupViews() {
        setupCentersMapView()
        setupBoroughCollectionView()
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

}
