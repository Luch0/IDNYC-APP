//
//  CentersListViewController.swift
//  IDNYC-APP
//
//  Created by Luis Calle on 4/26/18.
//  Copyright © 2018 Lucho. All rights reserved.
//

import UIKit

class CentersListViewController: UIViewController {
    
    let centersListView = CentersListView()
    
    var centers = [IDNYCCenter]() {
        didSet {
            DispatchQueue.main.async {
                self.centersListView.centersTableView.reloadData()
            }
        }
    }
    
    init(centers: [IDNYCCenter]) {
        self.centers = centers
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(centersListView)
        centersListView.centersTableView.delegate = self
        centersListView.centersTableView.dataSource = self
        setupNavBar()
    }
    
    private func setupNavBar() {
        navigationItem.largeTitleDisplayMode = .never
    }
    
}

extension CentersListViewController: UITableViewDelegate {
    
}

extension CentersListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return centers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let centerCell = tableView.dequeueReusableCell(withIdentifier: "center cell", for: indexPath) as! EnrollmentCenterTableViewCell
        centerCell.configureCel(center: centers[indexPath.row])
        return centerCell
    }
}
